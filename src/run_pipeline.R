library(Seurat)

process_scrnaseq <- function(input_dir, output_dir) {
  message("Loading raw data...")
  data <- Read10X(data.dir = input_dir)
  seurat_obj <- CreateSeuratObject(counts = data)
  
  message("Performing QC filtering...")
  seurat_obj <- subset(seurat_obj, subset = nFeature_RNA > 200 & nFeature_RNA < 2500 & percent.mt < 5)
  
  message("Normalizing data...")
  seurat_obj <- NormalizeData(seurat_obj)
  
  message("Finding variable features...")
  seurat_obj <- FindVariableFeatures(seurat_obj)
  
  message("Scaling data...")
  seurat_obj <- ScaleData(seurat_obj)
  
  message("Running PCA...")
  seurat_obj <- RunPCA(seurat_obj)
  
  message("Saving processed object...")
  saveRDS(seurat_obj, file = file.path(output_dir, "processed_seurat.rds"))
}

args <- commandArgs(trailingOnly = TRUE)
process_scrnaseq(args[1], args[2])
