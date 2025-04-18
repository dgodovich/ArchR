% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Trajectory.R
\name{getMonocleTrajectories}
\alias{getMonocleTrajectories}
\title{Get a Monocle CDS of Trajectories that can be added to an ArchRProject}
\usage{
getMonocleTrajectories(
  ArchRProj = NULL,
  name = "Trajectory",
  useGroups = NULL,
  principalGroup = NULL,
  groupBy = NULL,
  embedding = NULL,
  clusterParams = list(),
  graphParams = list(),
  seed = 1
)
}
\arguments{
\item{ArchRProj}{An \code{ArchRProject} object.}

\item{name}{A string indicating the name of the fitted trajectory.}

\item{useGroups}{A character vector that is used to select a subset of groups by name from the designated \code{groupBy} column
in \code{cellColData}. This limits the groups used to identify trajectories.}

\item{principalGroup}{The principal group which represents the group that will be the starting point for all trajectories.}

\item{groupBy}{A string indicating the column name from \code{cellColData} that contains the cell group definitions used in
\code{useGroups} to constrain trajectory analysis.}

\item{embedding}{A string indicating the name of the \code{embedding} object from the \code{ArchRProject} that should be used for trajectory analysis.}

\item{clusterParams}{A list of parameters to be added when clustering cells for monocle3 with \code{monocle3::cluster_cells}.}

\item{graphParams}{A list of parameters to be added when learning graphs for monocle3 with \code{monocle3::learn_graph}.}

\item{seed}{A number to be used as the seed for random number generation for trajectory creation.}
}
\description{
This function will use monocle3 to find trajectories and then returns a monocle CDS object that can be used as
input for \code{addMonocleTrajectory}.
}
\examples{

# Get Test ArchR Project
proj <- getTestProject()

#Create Monocole Trajectory
cds <- getMonocleTrajectories(
  ArchRProj = proj, 
  useGroups = c("C1", "C2", "C3"), 
  principalGroup = "C1", 
  groupBy = "Clusters", 
  embedding = "UMAP"
)

}
