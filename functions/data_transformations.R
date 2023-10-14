library(lubridate)
library(anytime)
#create a function that completes stations_metadata to a data frame
#Task 2

transform_metadata_to_df<- function (data){
  stations_data<-
  stations_metadata[[1]] %>% 
  map(as_tibble) %>% 
  list_rbind() %>% 
  mutate(latestData=map_chr(latestData,1,.default=NA_character_)) %>% # use map inside of mutate -> iterate over each item in the column
  mutate(latestData=as_datetime(latestData,tz="UTC")) %>% #change time zone to UTC
  mutate(location=map(location,unlist)) %>% 
  mutate(
    lat=map_dbl(location,"latLon.lat"), #seperate location data in lat and long
    lon=map_dbl(location,"latLon.lon")
  ) %>% 
  select(-location)
}


#Task 4a
to_iso8601<-function(date,offset){
  input_date<-date + days(offset) #adding offset to input date
  iso_date<-iso8601(anytime(input_date))# converting the date into iso8601 format
  cat(paste0(iso_date,"Z")) #adding Z to the date format
}
to_iso8601(as_datetime("2016-09-01 10:11:12"),-4)

#Task 5:
#i didnt manage to transform the data into a dataframe









