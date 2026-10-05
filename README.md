# Rutvik Shah — Enterprise Portfolio Website (Flutter Web)

A production-ready, highly responsive portfolio website designed and engineered with **Flutter Web** for **Rutvik Shah**, Senior Odoo Developer, Odoo Functional Consultant, and Solution Architect.

The application features a dual-profile switch (**"Developer View" ↔ "Functional View"**) allowing technical recruiters, enterprise clients, and Odoo partners to explore tailored perspectives of Rutvik's experience, architecture, custom modules, and business impact.

---

## 🚀 Key Architectural Highlights

- **Dual-Profile Paradigm**: Seamless real-time state toggle between technical engineering depth (Odoo ORM, PostgreSQL indexing, ICICI API webhooks) and functional solution architecture (dealership workflows, inter-branch accounting, GSTR statutory compliance).
- **Single Source of Truth**: All dynamic text, statistics, experience milestones, solutions, and links reside in [`lib/data/portfolio_data.dart`](file:///d:/portfolio/rutvik_portfolio/lib/data/portfolio_data.dart). No strings are hardcoded in presentation widgets.
- **Flutter CustomPainter Flow Engine**: Interactive dealership lifecycle diagram with animated pulse lines, glowing directional arrows, and step-level inspection.
- **Enterprise Design System**:
  - Palette inspired by Odoo purple (`#714B67`) accented with cyber cyan (`#00D2D3`) and deep navy charcoal (`#0B0F19`).
  - Google Fonts: **Poppins** for bold headers, **Inter** for readable body copy.
  - Soft glassmorphic cards with hover elevation and border radiance.
  - Count-up statistics counters and top scroll depth indicator.
- **Responsive Architecture**: Breakpoints for Mobile (<600px), Tablet (600–1024px), and Desktop (>1024px) utilizing [`ResponsiveBuilder`](file:///d:/portfolio/rutvik_portfolio/lib/core/utils/responsive_builder.dart).
- **Comprehensive Testing**: 100% passing unit tests for data models and widget tests for the view mode switch.
- **Static SEO & PWA**: Rich meta tags, OpenGraph previews, Twitter cards, CSS loading splash screen, and `<noscript>` fallback for search engine indexing.

---

## 📁 Project Structure

```text
rutvik_portfolio/
├── .github/
│   └── workflows/
│       └── deploy.yml             # Automated GitHub Actions workflow for GitHub Pages
├── assets/
│   ├── images/                    # Profile avatars, diagrams, logos
│   └── resumes/
│       ├── Rutvik_Shah_Developer_Resume.pdf
│       └── Rutvik_Shah_Functional_Resume.pdf
├── lib/
│   ├── core/
│   │   ├── constants/
│   │   │   └── app_constants.dart # Nav items, links, breakpoints, IDs
│   │   ├── theme/
│   │   │   ├── app_colors.dart    # Enterprise tech color palette & gradients
│   │   │   └── app_theme.dart     # Light/Dark ThemeData with Poppins & Inter
│   │   └── utils/
│   │       ├── responsive_builder.dart # Mobile/Tablet/Desktop helpers
│   │       └── url_launcher_helper.dart # Web links, mailto, tel, resume downloads
│   ├── data/
│   │   ├── models/
│   │   │   └── portfolio_models.dart # Typed records, enums, ViewMode
│   │   └── portfolio_data.dart    # Single source of truth data repository
│   ├── presentation/
│   │   ├── pages/
│   │   │   ├── not_found_page.dart # 404 fallback page
│   │   │   └── portfolio_page.dart # Single-page layout & scroll orchestrator
│   │   ├── providers/
│   │   │   └── portfolio_providers.dart # Riverpod state (ViewMode, Theme, Scroll)
│   │   ├── router/
│   │   │   └── app_router.dart    # GoRouter path strategy
│   │   ├── sections/
│   │   │   ├── about/             # Dynamic Dev/Functional summary & education
│   │   │   ├── contact/           # Validated contact form, direct channels, footer
│   │   │   ├── experience/        # Vertical timeline (Sunray & Geminate)
│   │   │   ├── flagship/          # Dealership ERP case study & CustomPainter
│   │   │   ├── hero/              # Typewriter ticker, dual resume CTA, socials
│   │   │   ├── marketplace/       # Odoo Apps Store publisher showcase
│   │   │   ├── navbar/            # Glass sticky header, drawer, toggle switches
│   │   │   ├── projects/          # New Vision Design residential portal
│   │   │   ├── skills/            # Verified skill chips by category (no fake %)
│   │   │   ├── solutions/         # Busy/Tally wizard, Security, QWeb, Accounting
│   │   │   ├── stats/             # Animated count-up metrics strip
│   │   │   └── strengths/         # 4 Core engineering and leadership pillars
│   │   └── widgets/
│   │       ├── animated_counter.dart # Ease-out counter animation
│   │       ├── custom_paint_erp_diagram.dart # Flutter CustomPainter flow engine
│   │       ├── custom_scroll_progress_bar.dart # Top gradient progress bar
│   │       ├── glass_container.dart # Glassmorphism card with hover lift
│   │       ├── section_header.dart  # Standardized enterprise section headers
│   │       └── view_toggle_switch.dart # Segmented profile switch
│   └── main.dart                  # ProviderScope, MaterialApp.router, scroll physics
├── test/
│   ├── data_model_test.dart       # Unit tests for data model integrity
│   ├── view_toggle_test.dart      # Widget test for ProfileViewMode state change
│   └── widget_test.dart           # Component smoke test for SectionHeader & Stats
├── web/
│   ├── 404.html                   # SPA routing fallback for GitHub Pages
│   └── index.html                 # SEO tags, splash loader, noscript metadata
├── analysis_options.yaml          # Strict static analysis configuration
└── pubspec.yaml                   # Dependencies & assets configuration
```

---

## 🛠️ Local Development & Execution

### 1. Prerequisites
- Flutter SDK **3.10.0+** (or Flutter 3.38+ stable).
- Google Chrome browser.

### 2. Install Packages
```bash
flutter pub get
```

### 3. Run Locally in Chrome
```bash
flutter run -d chrome
```

For hot reload and instant testing with custom web port:
```bash
flutter run -d chrome --web-port 3000
```

---

## 🧪 Testing & Code Quality

Run static analysis (configured for zero warnings):
```bash
flutter analyze
```

Run automated test suite:
```bash
flutter test
```

---

## 🌐 Production Build & Deployment

### GitHub Pages Release Build Command
When building for GitHub Pages, provide your GitHub repository name as `--base-href`:

```bash
flutter build web --release --base-href "/rutvik_portfolio/"
```

> **Note**: If deploying to a root custom domain (e.g. `https://rutvikshah.com/`) or user page `https://<username>.github.io/`, use `--base-href "/"` instead.

---

## 🚢 Automated CI/CD (GitHub Actions)

The repository includes a ready-to-run GitHub Actions workflow at [`.github/workflows/deploy.yml`](file:///d:/portfolio/rutvik_portfolio/.github/workflows/deploy.yml).

### Enabling GitHub Pages in Your Repository:
1. Push your repository to GitHub on branch `main`.
2. Go to **Settings > Pages** in your GitHub repository.
3. Under **Build and deployment > Source**, select **GitHub Actions**.
4. Every push to `main` will automatically:
   - Run `flutter analyze`
   - Run `flutter test`
   - Build the optimized release bundle
   - Deploy artifacts to GitHub Pages

---

## ⚡ Web Renderer Notes: CanvasKit vs HTML vs Auto

Flutter Web provides multiple rendering backends. You can select your renderer at build time:

1. **Auto (Default)**:
   ```bash
   flutter build web --release
   ```
   Flutter automatically uses HTML renderer on mobile browsers (faster initial download) and CanvasKit on desktop browsers (high performance).

2. **CanvasKit Renderer (`--web-renderer canvaskit`)**:
   ```bash
   flutter build web --release --web-renderer canvaskit
   ```
   - **Pros**: Pixel-perfect typography, smooth 60fps animations, rich CustomPainter hardware rendering, eliminates subtle browser DOM rendering quirks.
   - **Cons**: Requires downloading the CanvasKit WebAssembly bundle (~1.5MB gzip on first load).
   - **Recommendation**: Ideal for enterprise dashboards and desktop showcase portfolios.

3. **HTML / SkWasm Renderer (`--web-renderer html`)**:
   ```bash
   flutter build web --release --web-renderer html
   ```
   - **Pros**: Fastest initial load time; smaller download size.
   - **Cons**: Less consistent text rendering across varied browsers.

---

## 🔍 SEO Strategy & Flutter Web Caveats

### The Flutter Web SEO Challenge
Flutter Web renders UI inside a `<canvas>` element (or dynamic shadow DOM elements). Consequently, standard web crawlers that do not execute full JavaScript engines might see an empty body if proper fallbacks are omitted.

### Solutions Implemented in this Project:
1. **Static `<noscript>` Semantic Content**:
   `web/index.html` contains an accessible semantic fallback detailing Rutvik Shah's name, titles, years of experience, automotive dealership ERP achievements, education, and contact points for web scrapers and non-JS clients.
2. **Comprehensive Open Graph & Twitter Cards**:
   Enables rich link preview cards when sharing the portfolio on LinkedIn, Twitter, Slack, or WhatsApp.
3. **Structured Single-Page Architecture with URL Strategy**:
   Uses `go_router` with clean URL paths and `web/404.html` SPA routing redirection on static hosts like GitHub Pages.

---

## 📝 Assumptions & Placeholders (TODO)

The following items are configured as clean placeholders ready for your custom assets:
1. **Resume PDFs**: Replace the placeholder files at `assets/resumes/Rutvik_Shah_Developer_Resume.pdf` and `assets/resumes/Rutvik_Shah_Functional_Resume.pdf` with your updated PDF documents.
2. **Odoo Apps Store URL**: Currently set to `https://apps.odoo.com/apps/modules/browse?author=Rutvik%20Shah` in [`PortfolioData.odooAppsUrl`](file:///d:/portfolio/rutvik_portfolio/lib/data/portfolio_data.dart). Update if you have an exact author slug.
3. **Formspree Endpoint**: In `AppConstants.formspreeEndpoint` (or `PortfolioData`), you can insert your Formspree endpoint (e.g. `https://formspree.io/f/xyz...`). Currently, clicking "Send Message" automatically opens the client's mail software with pre-filled sender details and subject.
