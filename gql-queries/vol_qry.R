#Task 4b
library(httr)

vol_qry<- function(id,from, to){
  glue::glue(.open = "{{", .close = "}}",'{
    trafficData(trafficRegistrationPointId: "{{id}}") {
      volume {
        byHour(from: "{{from}}", to: "{{to}}") {
          edges {
            node {
              from
              to
              total {
                volumeNumbers {
                  volume
                }
              }
            }
          }
        }
      }
    }
  }'
  )
}


query_data<-GQL(
  vol_qry(
    id="81531V704884", 
    from="2023-08-14T12:00:00Z",
    to="2023-08-18T12:00:00Z"
  ),
  .url = configs$vegvesen_url
)
query_data

#the given code did not work for me. So i used the manual code above.
#However, I don't know how to transform that output to a format that can be used to make a plot
GQL(
 vol_qry(
    id=stations_metadata_df$id[1], 
    from=to_iso8601(stations_metadata_df$latestData[1],-4),
    to=to_iso8601(stations_metadata_df$latestData[1],0)
  ),
  .url = configs$vegvesen_url
)

