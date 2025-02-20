# Getting started with Targets package

To get started with Targets you first need to create an R project and then run in the **console** `install.packages("targets")`

Once installed we can create a targets file by entering the following into the **console**: `use_targets()`

This command will do a couple of things:

1.  It will create an `_targets` folder, this contains all of the cached data and job outputs, most of this is usually saved locally to the machine and not committed to github.
2.  A special file called \_targets.R is created - this is where you can add, modify, or remove jobs from your pipeline, as well as configure the required packages needed for each job to run

It is recommended to put all of your functions and code that is used by targets into the R/ folder. This is because the R folder is automatically sourced by targets

## Running Targets

There are a couple of commands you can run to execute your pipeline and use the output. First make sure you have the targets library sourced (`library("targets")`) this can be done in an R script or the console.

Once you have sourced the library you can call `tar_make()` to execute the pipeline. To fetch data to your plots or to the console you can run `tar_read(<job name>)` and to load data into your global environment you can run `tar_load(<job name>)`

For more detail you can see the [docs](https://books.ropensci.org/targets/)
