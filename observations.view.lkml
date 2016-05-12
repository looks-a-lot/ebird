view: observations {
  sql_table_name: ebird.observations ;;
  dimension: age_sex {
    type: string
    sql: ${TABLE}.age_sex ;;
  }
  
  dimension: all_species_reported {
    type: string
    sql: ${TABLE}.all_species_reported ;;
  }
  
  dimension: approved {
    type: string
    sql: ${TABLE}.approved ;;
  }
  
  dimension: brc_code {
    type: string
    sql: ${TABLE}.brc_code ;;
  }
  
  dimension: breeding_bird_atlas_code {
    type: string
    sql: ${TABLE}.breeding_bird_atlas_code ;;
  }
  
  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }
  
  dimension: common_name {
    type: string
    link: {
      label: "Search Lab of Ornithology"
      url: "https://www.allaboutbirds.org/search/?q={{ value | encode_uri }}"
      icon_url: "http://a2.mzstatic.com/us/r30/Purple49/v4/64/46/c7/6446c7eb-34ca-74ba-49f4-63c6ff216bdb/icon175x175.png"
    }
    sql: ${TABLE}.common_name ;;
  }
  
  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
  }
  
  dimension: country_code {
    type: string
    sql: ${TABLE}.country_code ;;
  }
  
  dimension: county {
    type: string
    sql: ${TABLE}.county ;;
  }
  
  dimension: county_code {
    type: string
    sql: ${TABLE}.county_code ;;
  }
  
  dimension: duration_minutes {
    type: string
    sql: ${TABLE}.duration_minutes ;;
  }
  
  dimension: effort_area_ha {
    type: string
    sql: ${TABLE}.effort_area_ha ;;
  }
  
  dimension: effort_distance_km {
    type: string
    sql: ${TABLE}.effort_distance_km ;;
  }
 
  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }
  
  dimension: full_name  {
    type: string
    sql: concat(${first_name}, ' ',  ${last_name}) ;;
  }
  dimension: global_unique_id {
    type: string
    sql: ${TABLE}.global_unique_id ;;
  }
  
  dimension: group_id_number {
    type: string
    sql: ${TABLE}.group_id_number ;;
  }
  
  dimension: group_identifier {
    type: string
    sql: ${TABLE}.group_identifier ;;
  }
  
  dimension: iba_code {
    type: string
    sql: ${TABLE}.iba_code ;;
  }
  
  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }
  
  dimension: latitude {
    type: number
    sql: ${TABLE}.latitude ;;
  }
  
  dimension: location {
    type:location
    sql_latitude: ${latitude} ;;
    sql_longitude: ${longitude} ;;
  }
  
  dimension: locality {
    type: string
    sql: ${TABLE}.locality ;;
  }
  
  dimension: locality_id {
    type: string
    sql: ${TABLE}.locality_id ;;
  }
  
  dimension: locality_type {
    type: string
    sql: ${TABLE}.locality_type ;;
  }
  
  dimension: longitude {
    type: number
    sql: ${TABLE}.longitude ;;
  }
  
  dimension: mysterty_column {
    type: string
    sql: ${TABLE}.mysterty_column ;;
  }
  
  dimension: number_observers {
    type: string
    sql: ${TABLE}.number_observers ;;
  }
  
  dimension: observation_count {
    type: string
    sql: ${TABLE}.observation_count ;;
  }
  
  dimension_group: observation {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.observation_date ;;
  }
  
  dimension: observer_id {
    type: string
    sql: ${TABLE}.observer_id ;;
  }
  
  dimension: project_code {
    type: string
    sql: ${TABLE}.project_code ;;
  }
  
  dimension: protocol_type {
    type: string
    sql: ${TABLE}.protocol_type ;;
  }
  
  dimension: reason {
    type: string
    sql: ${TABLE}.reason ;;
  }
  
  dimension: reviewed {
    type: string
    sql: ${TABLE}.reviewed ;;
  }
  
  dimension: sampling_event_identifier {
    type: string
    sql: ${TABLE}.sampling_event_identifier ;;
  }
  
  dimension: scientific_name {
    type: string
    link: {
      label: "Search Lab of Ornithology"
      url: "https://www.allaboutbirds.org/search/?q={{ value | encode_uri }}"
    }
    sql: ${TABLE}.scientific_name ;;
  }
  
  dimension: species_comments {
    type: string
    sql: ${TABLE}.species_comments ;;
  }
  
  dimension: state_code {
    type: string
    sql: ${TABLE}.state_code ;;
  }
  
  dimension: state_province {
    type: string
    sql: ${TABLE}.state_province ;;
  }
  
  dimension: subspecies_common_name {
    type: string
    sql: ${TABLE}.subspecies_common_name ;;
  }
  
  dimension: subspecies_scientific_name {
    type: string
    sql: ${TABLE}.subspecies_scientific_name ;;
  }
  
  dimension: taxonomic_order {
    type: string
    sql: ${TABLE}.taxonomic_order ;;
  }
  
  dimension: trip_comments {
    type: string
    sql: ${TABLE}.trip_comments ;;
  }
  
  measure: count {
    type: count
    # approximate_threshold:100000
    drill_fields: [detail*]
  }
  measure: species_count {
    type: count_distinct
    drill_fields: [full_name, subspecies_common_name, common_name, scientific_name, subspecies_scientific_name, locality]
    # approximate_threshold:1000000
    sql: ${scientific_name}  ;;
  }
  measure: location_count {
    type: count_distinct
    # approximate_threshold:1000000
    sql: ${locality} ;;
  }
  
  measure: sampling_count {
    type: count_distinct
    drill_fields: [full_name, subspecies_common_name, common_name, scientific_name, subspecies_scientific_name]
    sql: ${sampling_event_identifier} ;;
  }
  
  measure: average_species  {
    type: average
    drill_fields: [full_name, subspecies_common_name, common_name, scientific_name, subspecies_scientific_name, locality]
    sql: ${species_count};;
  }
  measure: observer_count {
    type: count_distinct
    drill_fields: [full_name, observer_id, locality, species_count]
    sql: ${observer_id};;
  }
  
    filter: name_select {
      suggest_dimension: full_name
    }
    
    dimension:name_comparitor  {
      sql: case when {% condition name_select %} ${full_name} {% endcondition %} then ${full_name} else 'Rest Of Population' end;;
    }
  set: detail {
    fields: [subspecies_common_name, common_name, first_name, last_name, scientific_name, subspecies_scientific_name]
  }
  
}

