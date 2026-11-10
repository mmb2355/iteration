birthday_repeated = function (n = 5){
  
  birthdays = sample(1:365, size = n, replace = TRUE)
  
  repeated_birthdays = length(unique(birthdays)) < n
  
  return(repeated_birthdays)
}