# Define functions for each step of the analysis workflow

loadLibraries <- function() {
  library(Seurat)
  library(tidyverse)
}

loadNSCLCData <- function(filename) {
  nsclc.sparse.m <- Read10X_h5(filename = filename)
  return(nsclc.sparse.m)
}

initializeSeuratObject <- function(cts, project, min.cells, min.features) {
  nsclc.seurat.obj <- CreateSeuratObject(counts = cts, project = project, min.cells = min.cells, min.features = min.features)
  return(nsclc.seurat.obj)
}

performQC <- function(nsclc.seurat.obj) {
  nsclc.seurat.obj[["percent.mt"]] <- PercentageFeatureSet(nsclc.seurat.obj, pattern = "^MT-")
  return(nsclc.seurat.obj)
}

filterData <- function(nsclc.seurat.obj) {
  nsclc.seurat.obj <- subset(nsclc.seurat.obj, subset = nFeature_RNA > 200 & nFeature_RNA < 2500 & percent.mt < 5)
  return(nsclc.seurat.obj)
}

normalizeData <- function(nsclc.seurat.obj) {
  nsclc.seurat.obj <- NormalizeData(nsclc.seurat.obj)
  return(nsclc.seurat.obj)
}

identifyHighlyVariableFeatures <- function(nsclc.seurat.obj) {
  nsclc.seurat.obj <- FindVariableFeatures(nsclc.seurat.obj, selection.method = "vst", nfeatures = 2000)
  return(nsclc.seurat.obj)
}

scaleData <- function(nsclc.seurat.obj) {
  all.genes <- rownames(nsclc.seurat.obj)
  nsclc.seurat.obj <- ScaleData(nsclc.seurat.obj, features = all.genes)
  return(nsclc.seurat.obj)
}

performLinearDimensionalityReduction <- function(nsclc.seurat.obj) {
  nsclc.seurat.obj <- RunPCA(nsclc.seurat.obj, features = VariableFeatures(object = nsclc.seurat.obj))
  return(nsclc.seurat.obj)
}

clusterData <- function(nsclc.seurat.obj, dims, resolution) {
  nsclc.seurat.obj <- FindNeighbors(nsclc.seurat.obj, dims = dims)
  nsclc.seurat.obj <- FindClusters(nsclc.seurat.obj, resolution = resolution)
  return(nsclc.seurat.obj)
}

performNonLinearDimensionalityReduction <- function(nsclc.seurat.obj, dims) {
  nsclc.seurat.obj <- RunUMAP(nsclc.seurat.obj, dims = dims)
  return(nsclc.seurat.obj)
}
