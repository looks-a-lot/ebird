connection: "lookerdata_publicdata"
include: "*.view.lkml"
include: "*.dashboard.lkml"


explore: observations {
  join: affinity {
    from: observations
    relationship: one_to_many
    sql_on: ${observations.sampling_event_identifier} = ${affinity.sampling_event_identifier};;
  }
}