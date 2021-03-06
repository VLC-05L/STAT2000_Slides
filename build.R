
local({
  # set a stable mirror
  r <- getOption("repos")
  r["CRAN"] <- "https://cran.microsoft.com/snapshot/2020-01-01"
  options(repos = r)
})

if ( ! require(rmarkdown))
  install.packages('rmarkdown')
if ( ! require(xaringan))
  install.packages('xaringan')


# Loop for builds
Rmds = NULL
for (i in 1:12){
  path.i = paste0("./Week_",if(nchar(x = toString(i))==1)paste0("0",i) else toString(i),"_2020")
  Rmds[i] = list.files(path = path.i, pattern='Week_.*_2020.Rmd')
}

Rmd_index = 1:length(Rmds)

i=1
for (i in 1:length(Rmds)) {
  Rmd = Rmds[i]
  match <- regexec('^(.*)\\.Rmd$', Rmd)
  name <- substring(Rmd, 1, nchar(Rmd)-4)
  output_q <- paste(name, '.html', sep="")
  
  rmarkdown::render(
    input=Rmd,
    output_format='xaringan::moon_reader',
    output_file=output_q,
    params=list(inc_solu=FALSE))

}

# Files for an index - still based on lab, would need updating
#files <- list.files(pattern='Lab*.*')
#files <- c(files, 'all.zip')
#links <- sapply(files, function(x) paste0(' - [', x, '](', URLencode(x), ')'))

# tweaky sort
#links <- gsub('-', '~', links, fixed=TRUE)
#links <- sort(links)
#links <- gsub('~', '-', links, fixed=TRUE)

#index <- paste0('# index\n\n', paste0(links, collapse='\n'))

#writeLines(index, 'index.Rmd')

#rmarkdown::render(
#  input='index.Rmd',
#  output_format='html_document',
#  output_file='index.html')
