# When used together, the makeCacheMatrix() and cacheSolve() functions 
# calculate the inverse of a square, invertible matrix that is passed to the 
# makeCacheMatrix() function. This calculated inverse matrix is then cached
# and can be retrieved from the cache later if the same square, invertible 
# matrix is again passed to the makeCacheMatrix() function. The purpose of 
# caching the inverse matrix is to speed up calculations of inverting
# large matrices. 

# The makeCacheMatrix() function takes one argument, a matrix, which we assume
# to be a square, invertible matrix. It then assigns the value NULL to the 
# variable 'inv' and then defines 4 functions: set(), get(), setinv(), and 
# getinv(). Running this makeCacheMatrix() function by itself produces a list
# that contains these 4 functions. Thus, we can call a particular function
# that is defined within the scope of the makeCacheMatrix() function like we 
# would extract an element from any list - by using the $ symbol. 
makeCacheMatrix <- function(x = matrix()) {
      inv <- NULL
      set <- function(y) {
            x <<- y
            inv <<- NULL
      }
      get <- function() x
      setinv <- function(inverse) inv <<- inverse
      getinv <- function() inv
      list(set = set, get = get, setinv = setinv, getinv = getinv)
}

# The cacheSolve() function requires one argument, x, which in this case
# will be the makeCacheMatrix() function. It can also take additional 
# arguments via the ... argument, which are then passed to the solve(data, ...)
# function. This cacheSolve() function gets the value of 'inv' via the 
# getinv() function, which is an element from the list produced by the 
# makeCacheMatrix() function, and stores it in the variable 'inv' in the 
# scope of the cacheSolve() function. If this value for 'inv' is not NULL, 
# then its value is returned and the function is finished executing. If the
# value for 'inv' is NULL, then the cacheSolve() function calculates the 
# inverse of the matrix passed to the makeCacheMatrix() function, caches this 
# inverse via the setinv() function, and then returns this inverse to the 
# console. 
cacheSolve <- function(x, ...) {
      inv <- x$getinv()
      if(!is.null(inv)) {
            message("getting cached data")
            return(inv)
      }
      data <- x$get()
      inv <- solve(data, ...)
      x$setinv(inv)
      inv
}




