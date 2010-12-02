# acts_as_viewable

A rather application specific gem for rails 2 which adds the ability to count views of your records.

When a model `acts_as_viewable` its instances are endowed with a `view!` method, which takes a single argument - an IP address. Invoking `view!` on a record records the viewing and increments a counter *unless* the IP in question has viewed this record within the last *n* minutes, where *n* can be specified in minutes via the `:ttl` option to `acts_as_viewable` (defaults to 60).

A rake task is provided for pruning view recordings.

## Installation

	config.gem 'acts_as_viewable'

	$ rake gems:install
	$ ./script/generate acts_as_viewable
	$ rake db:migrate

## Example

	class Foo < ActiveRecord::Base
		acts_as_viewable :ttl => 60 * 24
	end

	class FoosController < ActionController::Base
		def show
			@foo = Foo.find(params[:id])
			@foo.view!(request.remote_ip)
			@total_viewings_for_all_time = @foo.views
			@records_of_viewings = @foo.viewings
			@twelve_most_viewed_foos_of_all_time = Foo.most_viewed(12)
		end
	end

To delete viewing records greater than 10 days old.

	$ rake acts_as_viewable:delete_old_records[10]

This will not effect the total viewings of any record.

## Copyright

Copyright (c) 2010 iorum design & technology consultants. See MIT-LICENSE for further details.