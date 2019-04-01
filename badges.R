### Load Packages ###
library(parallel)
library(data.table)
library(rAltmetric)

### Options ###
options(altmetricKey = readLines('~/Documents/Karolina/Retractobot/altmetric_key.txt'))

### PubMed IDs ###
doi <- list(
  "10.1136/bmj.k1450",
  "10.1186/s41512-018-0035-4",
  "10.1186/s13063-017-2070-9",
  "10.1186/s13063-016-1720-7",
  "10.1111/dme.13259",
  "10.1515/cclm-2016-0303",
  "10.1111/bcp.12543"
)
#pmid <- c(29785952, 28701195, 27955685, 27588354, 27658148, 25377481)

### Define Extraction Function ###
extract_alt <- function(doi){
  alt <- tryCatch({
    altmetrics(doi = doi)
  },
  error = function(e){
    message(paste("DOI:", doi, "not found!"))
    return(NULL)
  })
  if(is.null(alt)){
    dt <- data.table(
      #pmid = NA,
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
      #pmid = alt[["pmid"]],
      doi = alt[["doi"]],
      #authors = paste(alt[["authors"]][(length(alt[["authors"]] + 1)):length(alt[["authors"]])], collapse = ", "),
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
  return(dt)
}

### Scrape Data Using Function ###
setDTthreads(1L)
dt <- mclapply(doi, extract_alt); rm(doi)
setDTthreads(detectCores())

### Collate Results ###
dt <- rbindlist(dt)

### Get Badges ###
dt <- dt[complete.cases(badge)]
pmid <- dt$pmid
url <- dt$badge
getBadge <- function(pmid, url){
  download.file(url, paste0("./images/", pmid, ".png"), mode = "wb", quiet = T)
}
setDTthreads(1L)
mcmapply(getBadge, pmid, url)
setDTthreads(detectCores())