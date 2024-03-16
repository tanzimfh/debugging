package idleaf


default allow := false

result := {
	"allow": allow,
	"errors": outcome,
}

allow if {
	input.action in object_roles
}

outcome[msg] if {
	not allow
	msg := sprintf("access_denied: `%s` is not allowed to perform action `%s` on key `%s`", [input.user, input.action, input.key,])
}

outcome[msg] if {
    allow
	msg := sprintf("acess_granted: `%s` on key `%s` by user `%s`", [input.action, input.key, input.user])
}

all_entities contains e if {
	input.keys[_][e]
}

all_entities contains input.user

all_entities contains input.teams[_][_]

access_graph[entity] = edges if {
	some entity in all_entities
	edges := {team | entity == input.teams[team][_]}
}

related_entities[entity] = entities if {
	some entity in all_entities
	entities := access_graph[entity] | related_entities[access_graph[entity][_]]
}

object_roles = {r | r := object_acl[entities[_]]} if {
	user := input.user
	object_acl := input.keys[input.key]
	entities := related_entities[user] | {input.user}
}
