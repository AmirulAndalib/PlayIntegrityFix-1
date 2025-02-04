## Keybox Explanation

- **Issuance and Usage:** Google issues the certificates, and OEMs sign and use them.

- **Serial Numbers:** Each certificate is assigned a serial number. There are four main types of serials:

    1. **Google Serial:**
        - This serial is issued by Google.
        - It remains **constant** and is **never revoked**.
        - If the Google serial were to be revoked, it would invalidate all keystores.

    2. **OEM Serial:**
        - This serial is issued by the OEM (Original Equipment Manufacturer).
        - It is subject to **change** and is device-specific.
        - I haven't yet observed an OEM serial being revoked.

    3. **Device Serial:**
        - This serial is **revoked**.
        - It appears to be the primary serial that gets targeted for revocation actions.

    4. **User-Added/Manual Serial:**
        - These serials are added manually, likely by users or for specific purposes.
        - They often have an **expiration date**.
        - They can be subject to **soft bans**.

- **Revocation and New Certificates:**
    - When a new certificate is added, the Google (1), OEM (2), and Device (3) serials typically **remain the same**.
    - This allows Google to still maintain revocation capabilities, likely targeting the Device (3) serial.

# Keybox Sellers 
You should not buy sold Keybox files, vendors use a method of buying a valid keybox and re-signing it (4 certificate chains so re-signing is easy). The only thing that really matters is the oem keys inside TEE (explained in cleverestech group).
