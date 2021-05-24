### Packages ###
## Create Local Library ##
dir_pkgs <- file.path(getwd(), 'packages')
dir.create(dir_pkgs, showWarnings = F, mode = '0755')

## Append to Path ##
lib.loc <- append(x = .libPaths(), values = dir_pkgs, after = 0)
.libPaths(new = lib.loc)

## Install/Update ##
if (!{'rAltmetric' %in% installed.packages()}) {
  
  install.packages(
    lib = lib.loc[1],
    pkgs = 'rAltmetric',
    repos = 'https://cloud.r-project.org/',
    clean = T
  )
  
}

## Load Packages ##
library(package = rAltmetric, lib.loc = lib.loc)

### Create Badges Folder ###
dir.create('badges', showWarnings = F, mode = '0755')

### DOIs ###
doi <- list(
  '10.1136/bmjopen-2018-028062',
  '10.1136/bmj.k1450',
  '10.1186/s41512-018-0035-4',
  '10.1186/s13063-017-2070-9',
  '10.1186/s13063-016-1720-7',
  '10.1111/dme.13259',
  '10.1515/cclm-2016-0303',
  '10.1111/bcp.12543',
  '10.1136/bmj.k4738',
  '10.1016/j.jnucmat.2018.04.022',
  '10.1136/bmj.k2387',
  '10.1136/bmjopen-2017-019637',
  '10.12688/f1000research.20229.1',
  '10.3399/bjgpopen20x101016',
  '10.1371/journal.pmed.1003478'
)

### Define Altmetric Data Extraction Function ###
extract_alt <- function(doi, hps.max = 1){
  
  ## Timer Start ##
  time1 <- Sys.time()
  
  alt <- tryCatch({
    
    altmetrics(doi = doi)
    
  },
  
  error = function(e){
    
    warning(paste('DOI:', doi, 'not found!'))
    return(NULL)
    
  })
  
  if(is.null(alt)){
    
    dat <- data.frame(
      pmid = NA_character_,
      doi = NA_character_,
      authors = NA_character_,
      title = NA_character_,
      year = NA_integer_,
      journal = NA_character_,
      url = NA_character_,
      badge = NA_character_,
      score = NA_real_
    )
    
  } else {
    
    ## Format Authors ##
    alt[['authors']] <- alt[['authors']]
    i <- length(alt[['authors']])
    alt[['authors']] <- alt[['authors']][1:(i/2)]
    alt[['authors']] <- paste(alt[['authors']], collapse = ', ')
    
    ## Format Year ##
    alt[['published_on']] <- as.POSIXct(alt[['published_on']], origin = '1970-01-01')
    alt[['published_on']] <- as.integer(substr(alt[['published_on']], 1, 4))
    
    ## Check for Missing PMID ##
    if (is.null(alt[['pmid']])) alt[['pmid']] <- NA_character_
    
    ## Format Output ##
    dat <- data.frame(
      pmid = alt[['pmid']],
      doi = alt[['doi']],
      authors = alt[['authors']],
      title = alt[['title']],
      year = alt[['published_on']],
      journal = alt[['journal']],
      url = alt[['url']],
      badge = alt[['images.large']],
      score = alt[['score']]
    )
    
  }
  
  ## Timer Stop ##
  time2 <- Sys.time()
  timer <- difftime(time2, time1, units = 'secs')
  
  ## Rate Limiter ##
  delay <- 1/hps.max
  if (timer < delay) Sys.sleep(delay - timer)
  
  ## Output ##
  return(dat)
  
}

### Scrape Altmetric Data ###
dat <- suppressWarnings(lapply(doi, extract_alt, hps.max = 1)); rm(doi)

### Collate Results ###
dat <- do.call(rbind, dat)

### Define Rosette Data ###
dat <- dat[complete.cases(dat[['badge']]), ]
url <- dat[['badge']]
doi <- gsub('[[:punct:]]', '_', dat[['doi']])
doi <- file.path('.', 'badges', paste(doi, 'png', sep = '.'))

### Define Rosette Extraction Function ###
getBadge <- function(doi, url){
  ## Download Badge ##
  rc <- download.file(url = url, destfile = doi, quiet = T, mode = 'wb')
  
  ## Output ##
  return(rc)
}

### Scrape Altmetric Rosettes ###
invisible(mapply(getBadge, doi, url))
