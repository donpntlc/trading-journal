# Trading-Journal

Ein Trading-Journal für Futures (Vorbereitung, Trades, Tagestyp-Check, Fehler-Tracking, Auswertung, mehrere Konten).
Läuft im Browser auf PC, Laptop und Handy (zum Home-Bildschirm hinzufügen). Die Daten liegen in deiner eigenen Supabase-Datenbank, geschützt durch deinen Login.

Die App enthält **keine Strategie**. Deine Regeln (Tagestyp-Check, Delta-Regeln, Fehlerliste, Gegenmaßnahmen) liegen in deiner Datenbank unter `settings` → Schlüssel `strategy` und sind nur nach dem Login sichtbar.

## Eigene Kopie einrichten (ca. 15 Minuten)

1. **Supabase:** Auf supabase.com ein kostenloses Konto und ein neues Projekt anlegen (Region z. B. Zürich oder Frankfurt).
2. **Datenbank:** Im Projekt den *SQL Editor* öffnen, den Inhalt von `schema.sql` einfügen und ausführen.
3. **Kopie der App:** Dieses Repo auf GitHub *forken* (oder die Dateien in ein eigenes Repo legen).
4. **Verbindung:** In `config.js` die zwei Werte ersetzen (Supabase → Project Settings → API: *Project URL* und *Publishable key*).
5. **Online stellen:** Im eigenen Repo *Settings → Pages → Branch: main* wählen. Nach 1–2 Minuten ist die App unter `https://<name>.github.io/<repo>/` erreichbar.
6. **Konto anlegen:** App öffnen, mit E-Mail und Passwort registrieren. Danach in Supabase unter *Authentication → Sign In / Providers* „Allow new users to sign up“ ausschalten, damit sich niemand sonst registriert.
7. **Mit Claude arbeiten:** In Claude den Supabase-Connector mit dem eigenen Projekt verbinden. Claude kann dann Trades auswerten und die Strategie (`settings/strategy`) gemeinsam mit dir eintragen.
