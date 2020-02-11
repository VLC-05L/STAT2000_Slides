# setwd("C:/Users/glj542/Google Drive/STAT2000_Materials/STAT2000_Slides")
# rm(list = ls())

local({
  # set a stable mirror
  r <- getOption("repos")
  r["CRAN"] <- "https://cran.microsoft.com/snapshot/2020-01-01"
  options(repos = r)
})

if ( ! require(rmarkdown))
  install.packages('rmarkdown')

if ( ! require(revealjs))
  install.packages("revealjs")


Rmds <- list.files(pattern='.*\\.Rmd')

#Rmd = Rmds[1]
for (Rmd in Rmds) {
  print("LOOP-START")
  
  match <- regexec('^(.*)\\.Rmd$', Rmd)
  name <- substring(Rmd, 1, nchar(Rmd)-4)
  output_L <- paste(name, '_Lecture.html',sep="")

  print("LOOP-MID")
  
  rmarkdown::render(
    input=Rmd,
#    output_format='html_document',
    output_file=output_L)

  print("LOOP-END")
}

if(1==0){
  files <- list.files(pattern='Lecture.html*.*')
  files <- c(files, 'all.zip')
  links <- sapply(files, function(x) paste0(' - [', x, '](', URLencode(x), ')'))
  
  # tweaky sort
  links <- gsub('-', '~', links, fixed=TRUE)
  links <- sort(links)
  links <- gsub('~', '-', links, fixed=TRUE)
  
  index <- paste0('# index\n\n', paste0(links, collapse='\n'))
  
  writeLines(index, 'index.Rmd')
  
  rmarkdown::render(
    input='index.Rmd',
    output_file='index.html')
  
}

