#!/bin/sh
### BEGIN INIT INFO
# Provides:          deluged
# Required-Start:    $local_fs $remote_fs
# Required-Stop:     $local_fs $remote_fs
# Should-Start:      $network
# Should-Stop:       $network
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Daemonized version of deluge and webui.
# Description:       Starts the deluge daemon with the user specified in
#                    /etc/default/deluge-daemon.
### END INIT INFO

# Author: Adolfo R. Brandes 
# Updated by: Jean-Philippe "Orax" Roemer

PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
DESC="Deluge Daemon"
NAME="deluged"
LOGFILE="/var/log/deluge/deluge.log"
DAEMON=/usr/bin/deluged
DAEMON_ARGS="-d -L INFO -l $LOGFILE"             # Consult `man deluged` for more options
PIDFILE=/var/run/$NAME.pid
UMASK=022                     # Change this to 0 if running deluged as its own user
PKGNAME=deluged
SCRIPTNAME=/etc/init.d/$PKGNAME

# Exit if the package is not installed
[ -x "$DAEMON" ] || exit 0

# Read configuration variable file if it is present
[ -r /etc/default/$PKGNAME ] && . /etc/default/$PKGNAME

# Load the VERBOSE setting and other rcS variables
[ -f /etc/default/rcS ] && . /etc/default/rcS

# Define LSB log_* functions.
# Depend on lsb-base (>= 3.0-6) to ensure that this file is present.
. /lib/lsb/init-functions

if [ -z "$RUN_AT_STARTUP" -o "$RUN_AT_STARTUP" != "YES" ]
then
   log_warning_msg "Not starting $PKGNAME, edit /etc/default/$PKGNAME to start it."
   exit 0
fi

if [ -z "$DELUGED_USER" ]
then
    log_warning_msg "Not starting $PKGNAME, DELUGED_USER not set in /etc/default/$PKGNAME."
    exit 0
fi

#
# Function to verify if a pid is alive
#
is_alive()
{
   pid=`cat $1` > /dev/null 2>&1
   kill -0 $pid > /dev/null 2>&1
   return $?
}

#
# Function that starts the daemon/service
#
do_start()
{
   # Return
   #   0 if daemon has been started
   #   1 if daemon was already running
   #   2 if daemon could not be started

   is_alive $PIDFILE
   RETVAL="$?"

   if [ $RETVAL != 0 ]; then
       rm -f $PIDFILE
       start-stop-daemon --start --background --quiet --pidfile $PIDFILE --make-pidfile \
       --exec $DAEMON --chuid $DELUGED_USER --user $DELUGED_USER --umask $UMASK -- $DAEMON_ARGS
       RETVAL="$?"
   else
       return 1
   fi
   [ "$RETVAL" = "0" ] || return 2
}

#
# Function that stops the daemon/service
#
do_stop()
{
   # Return
   #   0 if daemon has been stopped
   #   1 if daemon was already stopped
   #   2 if daemon could not be stopped
   #   other if a failure occurred

   start-stop-daemon --stop --quiet --retry=TERM/30/KILL/5 --user $DELUGED_USER --pidfile $PIDFILE
   RETVAL="$?"
   [ "$RETVAL" = "2" ] && return 2

   rm -f $PIDFILE

   [ "$RETVAL" = "0" ] && return 0 || return 1
}

case "$1" in
  start)
   [ "$VERBOSE" != no ] && log_daemon_msg "Starting $DESC" "$NAME"
   do_start
   RETVAL="$?"
   case "$RETVAL" in
      0|1) [ "$VERBOSE" != no ] && log_end_msg 0 ;;
      2) [ "$VERBOSE" != no ] && log_end_msg 1 ;;
   esac
   ;;
  stop)
   [ "$VERBOSE" != no ] && log_daemon_msg "Stopping $DESC" "$NAME"
   do_stop
   RETVAL="$?"
   case "$RETVAL" in
      0|1) [ "$VERBOSE" != no ] && log_end_msg 0 ;;
      2) [ "$VERBOSE" != no ] && log_end_msg 1 ;;
   esac
   ;;
  restart|force-reload)
   log_daemon_msg "Restarting $DESC" "$NAME"
   do_stop
   RETVAL="$?"
   case "$RETVAL" in
     0|1)
      do_start
      RETVAL="$?"
      case "$RETVAL" in
         0) log_end_msg 0 ;;
         1) log_end_msg 1 ;; # Old process is still running
         *) log_end_msg 1 ;; # Failed to start
      esac
      ;;
     *)
        # Failed to stop
      log_end_msg 1
      ;;
   esac
   ;;
  status)
   status_of_proc -p /var/run/$NAME.pid "$DAEMON" deluged && exit 0 || exit $?
   ;;
  *)
   echo "Usage: $SCRIPTNAME {start|stop|restart|force-reload|status}" >&2
   exit 3
   ;;
esac
return $RETVAL
