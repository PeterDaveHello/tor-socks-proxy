# Check if USERID is numeric. Since we're on busybox, use grep
# What actually happens here is that we change the UID of the tor user to $USERID, so that when /tor is mounted, the permissions match
# If no USERID is specified, we do NOT run as root though, but as user tor
echo ${USERID:-""} | grep -E '^[0-9]+$' && usermod -u $USERID -o tor && chown -R tor /tor
echo ${GROUPID:-""} | grep -E '^[0-9]+$' && groupmod -g $GROUPID -o tor
/usr/bin/tor -f /etc/tor/torrc
