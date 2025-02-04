# Telegram @cleverestech

DEVICE_ID="Device-$(openssl rand -hex 8)"
TITLE="TEE"

CA_KEY="ca.key"
CA_CRT="ca.crt"
DEVICE_KEY="device.key"
DEVICE_CSR="device.csr"
DEVICE_CRT="device.crt"
KEYBOX_XML="keybox.xml"

openssl genpkey -algorithm EC -pkeyopt ec_paramgen_curve:prime256v1 -out $CA_KEY
openssl req -x509 -new -key $CA_KEY -days 3650 -subj "/CN=cleverestech/title=$TITLE" -out $CA_CRT

openssl genpkey -algorithm EC -pkeyopt ec_paramgen_curve:prime256v1 -out $DEVICE_KEY
openssl req -new -key $DEVICE_KEY -subj "/CN=cleverestech /title=$TITLE" -out $DEVICE_CSR

openssl x509 -req -in $DEVICE_CSR -CA $CA_CRT -CAkey $CA_KEY -CAcreateserial -days 365 -out $DEVICE_CRT

DEVICE_KEY_PEM=$(sed 's/^/                /' $DEVICE_KEY)
DEVICE_CRT_PEM=$(sed 's/^/                    /' $DEVICE_CRT)

cat > $KEYBOX_XML <<EOF
<?xml version="1.0"?>
<AndroidAttestation>
    <NumberOfKeyboxes>1</NumberOfKeyboxes>
    <Keybox DeviceID="$DEVICE_ID">
        <Key algorithm="ecdsa">
            <PrivateKey format="pem">
$DEVICE_KEY_PEM
            </PrivateKey>
            <CertificateChain>
                <NumberOfCertificates>1</NumberOfCertificates>
                <Certificate format="pem">
$DEVICE_CRT_PEM
                </Certificate>
            </CertificateChain>
        </Key>
    </Keybox>
</AndroidAttestation>
EOF

echo "Generated Keybox asset: $KEYBOX_XML"
