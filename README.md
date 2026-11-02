# 🩸 Blood Whisperer
> *Ascolta il tuo corpo, comprendi il tuo ciclo.*

[![Flutter](https://img.shields.io/badge/Flutter-3.22+-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.3+-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web-brightgreen?style=for-the-badge)](https://flutter.dev)

**Blood Whisperer** è un'applicazione cross-platform moderna e privacy-first per il tracciamento del ciclo femminile, della salute ormonale e del benessere riproduttivo. Replica ed estende le funzionalità di app commerciali come **Flo**, integrando algoritmi statistici avanzati, gestione delle fasi della vita, grafici analitici e un assistente conversazionale integrato.

---

## 🌟 Caratteristiche Principali

- **4 Modalità Operative:** Si adatta dinamicamente a Cycle Tracking, Trying To Conceive, Pregnancy e Perimenopause.
- **Daily Logging Immutabile:** Tracciamento dettagliato di sintomi, umore, fluidi corporei, biometria (BBT), sonno, idratazione e attività sessuale.
- **Smart Analytics:** Grafici interattivi per la Temperatura Corporea Basale (BBT), l'andamento del peso e la frequenza dei sintomi.
- **Assistente Conversazionale In-App:** Chatbot locale contestuale che fornisce risposte, consigli lifestyle e informazioni mediche di base.
- **Importer Dati Flo:** Modulo di migrazione integrato per leggere e convertire export CSV/JSON da Flo.

---

## 🔄 Le 4 Modalità Operative

L'app adatta dinamicamente dashboard, calendari, algoritmi di calcolo e risposte dell'assistente in base alla fase della vita attiva:

| Modalità | Focus Principale | Funzionalità Chiave |
| :--- | :--- | :--- |
| 🌸 **Cycle Tracking** | Monitoraggio standard del ciclo | Previsione mestruazioni, calcolo fasi ormonali e durata. |
| 🪺 **Trying To Conceive** | Ricerca della gravidanza | Evidenziazione finestra fertile, picchi LH e rialzo termico BBT. |
| 🤰 **Pregnancy** | Gestione della gestazione | Conteggio settimane/giorni, trimestre e Data Presunta Parto (DPP). |
| 🍂 **Perimenopause** | Transizione ormonale | Rilevamento cicli irregolari, tracciamento vampate e variazioni. |

---

## 📝 Tracciamento Giornaliero (Daily Log)

Ogni log giornaliero è immutabile e gestito tramite **upsert per data** per evitare sovrapposizioni e duplicati:

- **Sintomi Fisici:** Crampi, mal di testa, gonfiore, acne, sensibilità al seno, affaticamento, mal di schiena, nausea, voglie, insonnia.
- **Umore & Stato Mentale:** Felicità, calma, ansia, irritabilità, tristezza, energia, stanchezza.
- **Fluidi Corporei:**
  - *Flusso Mestruale:* Spotting, Leggero, Medio, Abbondante.
  - *Muco Cervicale:* Asciutto, Appiccicoso, Cremoso, Acquoso, Filante.
- **Biometria & Stile di Vita:** Temperatura Corporea Basale (BBT con supporto decimale), Peso, Idratazione, Sonno (ore e qualità 1-5).
- **Attività:** Attività sessuale (protetta/non protetta) e note libere.

---

## 🧮 Algoritmi Intelligenti & Fisiologia

- **Statistiche Ciclo:** Calcolo della media e della deviazione standard. Soglia di regolarità impostata a deviazione standard <= 4 giorni.
- **Finestra Fertile:** Calcolata come i 5 giorni precedenti l'ovulazione più il giorno stesso (6 giorni totali).
- **Fasi Fisiologiche:**
  1. *Mestruale:* Dal giorno 1 alla durata mestruazioni (Estrogeni/Progesterone bassi).
  2. *Follicolare:* Dalla fine delle mestruazioni fino alla fase ovulatoria (Salita Estrogeni via FSH).
  3. *Ovulatoria:* Picco LH ed Estrogeni (1 giorno prima / 1 giorno dopo l'ovulazione).
  4. *Luteale:* Dall'ovulazione al termine del ciclo (Progesterone dominante).
- **Rilevamento Ovulazione (BBT):** Identificato tramite rialzo termico di almeno 0.2°C sostenuto per 3 giorni consecutivi rispetto ai 3 giorni precedenti.
- **Pattern Perimenopausa:** Attivazione automatica degli alert se deviazione standard > 7 giorni o se la differenza tra ciclo massimo e minimo > 14 giorni su almeno 6 cicli consecutivi.
- **Gravidanza (Regola di Naegele):** Data Presunta Parto = LMP + 280 giorni.

---

## 📥 Importer Dati da Flo

Ripristina o migra i tuoi dati dall'app Flo in totale sicurezza e in locale:

- **Formati Supportati:** CSV e JSON.
- **Parsing Flessibile:** Supporta formati data multipli (YYYY-MM-DD, DD/MM/YYYY, DD-MM-YYYY), sia punto che virgola nei decimali.
- **Dizionario Italiano Integrato:** Mappatura automatica di termini e keyword (es. spotting, light, heavy, cramps).
- **Report Finale:** Output dettagliato con totale righe, elementi importati, saltati ed errori.

---

## 💬 Assistente Conversazionale In-App

Un chatbot contestuale con risposta rapida (~400ms) che analizza lo stato corrente e restituisce risposte strutturate con **testo principale**, **suggerimenti** e **quick replies**:

- **Triggers:** Spiegazione fase, finestra fertile, settimane di gravidanza, analisi sintomi, andamento BBT, supporto umore/ansia, perimenopausa.
- **Disclaimer:** Ogni risposta include un avviso informativo (non costituisce diagnosi medica).

---

## 🛠️ Stack Tecnologico

| Componente | Tecnologia | Versione / Dettaglio |
| :--- | :--- | :--- |
| **Framework** | Flutter | >= 3.22 (Dart >= 3.3) |
| **State Management** | Riverpod | v2.5 (StateNotifierProvider, FutureProvider) |
| **Database Locale** | Drift / SQLite | v2.16 (Type-safe, local-first) |
| **Analytics & Grafici** | fl_chart | v0.68 |
| **Calendario** | table_calendar | v3.1 |
| **I/O & Utilities** | file_picker, csv, intl | File selection, CSV Parsing, Date Formatting |

---

## 🏗️ Architettura & Struttura del Progetto

Il progetto segue un’architettura a livelli con dipendenze gerarchiche unidirezionali per garantire **testabilità** e **modularità**:

- `lib/main.dart` - Entry Point con ProviderScope
- `lib/app.dart` - MaterialApp & AppTheme
- `lib/models/` - Domain Models & Enums (DailyLog, Cycle, AppMode, FloImport)
- `lib/database/` - Drift Schema, Tables & DAOs (app_database.dart)
- `lib/services/` - Business Logic (Cycle Calculation, Flo Importer, Chatbot)
- `lib/providers/` - Riverpod Providers (Database, Log, Cycle, AppState)
- `lib/features/` - Moduli Funzionali (Chat, Daily Log Form, Analytics, Flo Import)
- `lib/ui/screens/` - Home, Dashboard, Calendar, Settings, Onboarding
- `lib/ui/widgets/` - CycleRing, PhaseCard, FertileBadge, MetricTile
- `lib/ui/theme/` - AppColors, AppTextStyles, AppTheme
- `lib/utils/` - Helpers (DateUtils, Constants, Validators)

---

## 🚀 Setup & Installazione

### Prerequisiti
- **Flutter SDK:** >= 3.22
- **Android:** minSdkVersion 21
- **iOS:** Platform 12.0

### Step di Installazione

1. Clona il repository:
   git clone https://github.com/tuo-utente/blood_whisperer.git
   cd blood_whisperer

2. Installa le dipendenze:
   flutter pub get

3. Genera il codice del Database (Drift):
   dart run build_runner build --delete-conflicting-outputs

4. Verifica il progetto ed eseguilo:
   flutter analyze
   flutter run

---

## 📜 Comandi Utili CLI

- Watch mode per la generazione codice: `dart run build_runner watch --delete-conflicting-outputs`
- Esecuzione dei Test: `flutter test`
- Avvio su Browser Web: `flutter run -d chrome`
- Build di Release Android: `flutter build apk --release`
- Build di Release iOS: `flutter build ios --release`

---

## 🗺️ Roadmap di Sviluppo

- **v1.0 (Current):** 4 Modalità operative, Drift DB, Algoritmi Ciclo/BBT, Importatore Flo, Dashboard & Analytics, Chatbot locale.
- **v1.1:** Notifiche push locali (promemoria log/pillola), Widget Home Screen, Backup/Export cifrato, Onboarding interattivo.
- **v2.0:** Sincronizzazione Cloud E2EE (Opzionale), Integrazione Wearable/Smartwatch, AI Generativa avanzata, Grafici ML predittivi.

---

## ⚠️ Disclaimer Medico

> **IMPORTANTE:** Blood Whisperer è uno strumento informativo e di auto-monitoraggio. **Non fornisce diagnosi mediche**, non sostituisce il parere di un medico professionista e **non deve essere utilizzato come metodo contraccettivo**. Per qualsiasi dubbio o sintomo legato alla salute riproduttiva, consultare un medico qualificato.

---

## 📄 Licenza & Contatti

Distribuito sotto licenza **MIT**. Vedi `LICENSE` per ulteriori informazioni.

- **Author:** Gioele Valzolgher
- **Repository:** https://github.com/tuo-utente/blood_whisperer
