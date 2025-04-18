% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Trajectory.R
\name{addTrajectory}
\alias{addTrajectory}
\title{Add a Supervised Trajectory to an ArchR Project}
\usage{
addTrajectory(
  ArchRProj = NULL,
  name = "Trajectory",
  trajectory = NULL,
  groupBy = "Clusters",
  reducedDims = "IterativeLSI",
  embedding = NULL,
  preFilterQuantile = 0.9,
  postFilterQuantile = 0.9,
  useAll = FALSE,
  dof = 250,
  spar = 1,
  saveDF = NULL,
  force = FALSE,
  seed = 1,
  logFile = createLogFile("addTrajectory")
)
}
\arguments{
\item{ArchRProj}{An \code{ArchRProject} object.}

\item{name}{A string indicating the name of the fitted trajectory to be added in \code{cellColData}.}

\item{trajectory}{The order of cell groups to be used for constraining the initial supervised fitting procedure.
For example, to get a trajectory from Cluster1 to Cluster2 to Cluster3, input should be c("Cluster1", "Cluster2", "Cluster3").
Cells will then be used from these 3 groups to constrain an initial fit in the group order.}

\item{groupBy}{A string indicating the column name from \code{cellColData} that contains the cell group definitions used in
\code{trajectory} to constrain the initial supervised fitting procedure.}

\item{reducedDims}{A string indicating the name of the \code{reducedDims} object from the \code{ArchRProject} that should be used for distance computation.}

\item{embedding}{A string indicating the name of the \code{embedding} object from the \code{ArchRProject} that should be used for distance computation.}

\item{preFilterQuantile}{Prior to the initial supervised trajectory fitting, cells whose euclidean distance from the cell-grouping
center is above the provided quantile will be excluded.}

\item{postFilterQuantile}{After initial supervised trajectory fitting, cells whose euclidean distance from the cell-grouping center
is above the provided quantile will be excluded.}

\item{useAll}{A boolean describing whether to use cells outside of trajectory groups for post-fitting procedure.}

\item{dof}{The number of degrees of freedom to be used in the spline fit. See \code{stats::smooth.spline()} for more information.}

\item{spar}{The sparsity to be used in the spline fit. See \code{stats::smooth.spline()} for more information.}

\item{saveDF}{A full or relative path to use for creating a \code{.RDS} R object file containing a DataFrame with additional information about the trajectory.
This includes the distance of each cell to the splines of the trajectory and the corresponding indicies returned by \code{nabor::knn}.}

\item{force}{A boolean value indicating whether to force the trajactory indicated by \code{name} to be overwritten if it already exists in the given \code{ArchRProject}.}

\item{seed}{A number to be used as the seed for random number generation for trajectory creation.}

\item{logFile}{The path to a file to be used for logging ArchR output.}
}
\description{
This function will fit a supervised trajectory in a lower dimensional space that
can then be used for downstream analyses.
}
\examples{

# Get Test ArchR Project
proj <- getTestProject()

#Add Trajectory
proj <- addTrajectory(proj, trajectory = c("C1", "C2", "C3"), embedding = "UMAP", force = TRUE)

}
