# R function for the raster package
# Author: Robert J. Hijmans
# Date : September 2009
# Version 0.9
# Licence GPL v3


	
if (!isGeneric("zoom")) {
	setGeneric("zoom", function(x, ...)
		standardGeneric("zoom"))
}	


setMethod('zoom', signature(x='Raster'), 
function(x, ext=drawExtent(), maxpixels=100000, layer=1, new=TRUE, useRaster=TRUE, ...) {
	if (is.function(ext)) {
		ext <- ext  # force to start with drawing before creating a new graphics device
	} else {
		ext <- extent(ext)
	}
	if (new) { 
		dev.new() 
	}
	if (nlayers(x) > 1) { 
		x <- raster(x, layer) 
	}
	if (length(x@legend@colortable) > 0) {
		.plotCT(x, maxpixels=maxpixels, ext=ext, ...)
	} else if (useRaster) {
		.plotraster2(x, maxpixels=maxpixels, ext=ext, ...) 	
	} else {
		.plotraster(x, col=col, maxpixels=maxpixels, ...) 
	}
		
	return(invisible(ext))
}
)



setMethod('zoom', signature(x='Spatial'), 
function(x, ext=drawExtent(), new=TRUE, ...) {
	if (is.function(ext)) {
		ext <- ext  # force to start with drawing before creating a new graphics device
	} else {
		ext <- extent(ext)
	}
	if (new) { 
		dev.new()
	}
	sp::plot(x, xlim=c(ext@xmin, ext@xmax), ylim=c(ext@ymin, ext@ymax), ...)
	return(invisible(ext))
}
)



setMethod('zoom', signature(x='missing'), 
function(x, ext=drawExtent(), new=TRUE, ...) {
	if (is.function(ext)) {
		ext <- ext  # force to start with drawing before creating a new graphics device
	} else {
		ext <- extent(ext)
	}
	if (new) { 
		dev.new()
	}
	plot(0, xlim=c(ext@xmin, ext@xmax), ylim=c(ext@ymin, ext@ymax), type='n', ...)
	return(invisible(ext))
}
)
