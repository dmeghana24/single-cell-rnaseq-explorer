library(Seurat)

run_deg <- function(seurat_obj, cluster_col = "seurat_clusters") {
  markers <- FindAllMarkers(seurat_obj, only.pos = TRUE)
  return(markers)
}

# Example usage
# seurat_obj <- readRDS("processed_seurat.rds")
# deg_results <- run_deg(seurat_obj)
# write.csv(deg_results, file = "results/deg_markers.csv")
