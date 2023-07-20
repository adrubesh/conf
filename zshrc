if [ -d "${HOME}/.guix-profile" ]; then
	export GUIX_PROFILE="/home/aaron/.guix-profile"
	export GUIX_LOCPATH="${GUIX_PROFILE}/lib/locale"
	export SSL_CERT_DIR="${GUIX_PROFILE}/etc/ssl/certs"
	export SSL_CERT_FILE="${GUIX_PROFILE}/etc/ssl/certs/ca-certificates.crt"
	export GIT_SSL_CAINFO="$SSL_CERT_FILE"

	. "$GUIX_PROFILE/etc/profile"
fi
