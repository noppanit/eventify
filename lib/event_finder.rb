class EventFinder
	def find_by_id(event_id)
		query = "START events=node:events_index(name = 'events_index') MATCH events-[:has_event]-event WHERE event.event_id = '#{event_id}' RETURN event"
		results = $neo.execute_query(query)["data"]

		if results.empty?
			return nil
		end

		return results.first.first
	end
end
