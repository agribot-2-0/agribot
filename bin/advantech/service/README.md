Use 
$ loginctl enable-linger <username> 
to allow users to open their own service sessions.
Needed for advantech-log.service to be able to be called from hal_mobile_app.

For operating locally:
    in agribot_logging_start.sh change setup.bash advantech -> simulation
    in agribot_logging_stop.sh change setup.bash advantech -> simulation
    in advantech/service/user/advantech-log.service change path -> agribot1 -> <username>
To record all topics:
    in your selected topic list put "-a" instead of a topic list