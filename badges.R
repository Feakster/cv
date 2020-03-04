### Load Packages ###
library(data.table)
library(rAltmetric)

### Create Badges Folder ###
dir.create("badges", showWarnings = F)

### DOIs ###
doi <- list(
  "10.1136/bmjopen-2018-028062",
  "10.1136/bmj.k1450",
  "10.1186/s41512-018-0035-4",
  "10.1186/s13063-017-2070-9",
  "10.1186/s13063-016-1720-7",
  "10.1111/dme.13259",
  "10.1515/cclm-2016-0303",
  "10.1111/bcp.12543",
  "10.1136/bmj.k4738",
  "10.1016/j.jnucmat.2018.04.022",
  "10.1136/bmj.k2387",
  "10.1136/bmjopen-2017-019637",
  "10.12688/f1000research.20229.1",
  "10.3399/bjgpopen20X101016"
)

### Define Altmetric Data Extraction Function ###
extract_alt <- function(doi,  hps.max = 1){
  time1 <- Sys.time()
  alt <- tryCatch({
    altmetrics(doi = doi)
  },
  error = function(e){
    message(paste("DOI:", doi, "not found!"))
    return(NULL)
  })
  if(is.null(alt)){
    dt <- data.table(
      pmid = NA,
      doi = NA,
      authors = NA,
      title = NA,
      year = NA,
      journal = NA,
      url = NA,
      badge = NA,
      score = NA
    )
  }
  if(!is.null(alt)){
    authors <- alt[["authors"]]
    i <- length(authors)
    authors <- authors[1:(i/2)]
    dt <- data.table(
      pmid = if(!is.null(alt[["pmid"]])){alt[["pmid"]]} else {NA},
      doi = alt[["doi"]],
      authors = paste(authors, collapse = ", "),
      title = alt[["title"]],
      year = alt[["published_on"]],
      journal = alt[["journal"]],
      url = alt[["url"]],
      badge = alt[["images.large"]],
      score = alt[["score"]]
    )
  }
  dt[, year := year(as.POSIXct(year, origin = "1970-01-01"))]
  time2 <- Sys.time()
  timer <- difftime(time2, time1, units = "secs")
  delay <- 1/hps.max
  if (timer < delay) Sys.sleep(delay - timer)
  return(dt)
}

### Scrape Altmetric Data ###
dt <- suppressMessages(lapply(doi, extract_alt, hps.max = 1)); rm(doi)

### Collate Results ###
dt <- rbindlist(dt)

### Define Rosette Data ###
dt <- dt[complete.cases(badge)]
doi <- gsub("[[:punct:]]", "_", dt[, doi])
url <- dt[, badge]

### Define Rosette Extraction Function ###
getBadge <- function(doi, url){
  download.file(url, paste0("./badges/", doi, ".png"), mode = "wb", quiet = T)
}
### Scrape Altmetric Rosettes ###
invisible(mapply(getBadge, doi, url))
