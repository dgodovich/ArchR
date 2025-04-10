% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/HelperUtils.R
\name{\%bcni\%}
\alias{\%bcni\%}
\title{Negated matching function for S4Vector objects}
\usage{
x \%bcni\% table
}
\arguments{
\item{x}{An \code{S4Vector} object to search for in \code{table}.}

\item{table}{The set of \code{S4Vector} objects to serve as the base for the match function.}
}
\description{
This function provides the reciprocal of \%bcin\% for S4Vector objects primarily to avoid ambiguity.
}
\examples{

#Test
Rle(c("A", "B", "C")) \%bcni\% Rle(c("A", "C"))

}
