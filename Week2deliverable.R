# Momentum magnitude = sqrt(px^2 + py^2 + pz^2) from the 3D momentum vector components
calculate_momentum <- function(px, py, pz) {
  sqrt(px^2 + py^2 + pz^2)
}
main <- function(filename) {
  infile <- file(filename, "r")  # open the fine for reading (line by line)

  #header line: "<event_id> <n_particles>". read once before the loop
  first_line <- strsplit(readLines(infile, n = 1), " ")[[1]]
  event_id <- first_line[1] #first value in header = event id is kept as a string
  n_particles <- as.integer(first_line[2])  # converts to integers as readLines gives strings

  cat("Event", event_id, "-", n_particles, "particles\n") #prints header 

  # loop runs once per particle line, using n_particles from the header so we never read past the particles that belong to this event
  for (i in 1:n_particles) { # loop runs exactly n_particles times 
    line <- strsplit(readLines(infile, n = 1), " ")[[1]] # read next line that's separated by spaces 
    px <- as.numeric(line[1]) #first value --> x-momentum, cast to numeric 
    py <- as.numeric(line[2]) #second value --> y-momentum cast to numeric
    pz <- as.numeric(line[3]) # third value --> z-momentum cast to numeric 
    code <- line[4]  # particle type/ID is kept as string (not used in the calculation)

    p <- calculate_momentum(px, py, pz) #calculates particle's momentum
    cat("Particle", i, "| code =", code, "| p =", p, "\n") # prints result
  }
  close(infile)  # close file connections once done reading
}
main("output-Set0.txt")