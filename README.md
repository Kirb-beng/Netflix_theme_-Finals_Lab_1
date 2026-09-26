# Netflix Clone — ITP107 Finals Lab 1

Isang 3-screen na Flutter app (Login → Sign-Up → Home) na ginawang mukhang
kapareho ng Netflix login/sign-up/home UI, gamit ang **named routes** at
**Navigator methods**, bilang sagot sa ITP107 Finals Laboratory 1.

## Paano patakbuhin

1. I-install ang [Flutter SDK](https://docs.flutter.dev/get-started/install) kung wala ka pa.
2. I-extract ang zip file, pagkatapos sa terminal:
   ```
   cd netflix_clone
   flutter pub get
   flutter run
   ```
3. Pwede mo itong patakbuhin sa Android emulator, iOS simulator, Chrome
   (`flutter run -d chrome`), o sa Windows/Mac/Linux desktop.

## Istruktura ng project

```
netflix_clone/
├── pubspec.yaml
├── assets/
│   └── images/
│       ├── netflix_bg.jpg      # collage background (Login, Sign-Up, Home hero)
│       └── netflix_intro.gif   # red "ta-dum" splash animation
└── lib/
    ├── main.dart                    # MaterialApp + named routes (onGenerateRoute)
    ├── theme/
    │   ├── netflix_theme.dart       # shared colors, text styles, input/button styles
    │   └── route_transitions.dart   # fade + slide-up page transition used app-wide
    ├── widgets/
    │   └── netflix_background.dart  # collage background w/ dark scrim, logo, fade-in animation
    └── screens/
        ├── splash_screen.dart       # plays the intro gif, then fades into Login
        ├── login_screen.dart
        ├── signup_screen.dart
        └── home_screen.dart
```

## Animations included

- **Splash screen**: plays `netflix_intro.gif` (the classic red "ta-dum" bars)
  for ~2.6s, fading into the Login screen afterward.
- **Page transitions**: every named route (`onGenerateRoute` in `main.dart`)
  is wrapped in a shared fade + slight slide-up transition
  (`netflixFadeRoute`), so moving between Login ↔ Sign-Up ↔ Home always
  feels consistent.
- **Form fade-in**: the Login and Sign-Up cards fade and rise into place on
  load using the reusable `FadeSlideIn` widget.
- **Button press feedback**: the "Sign In" / "Sign Up" buttons scale down
  slightly on tap for tactile feedback (`_AnimatedPressButton`).
- **Home screen**: the hero banner and each content row (Trending Now,
  Because You Watched, New Releases) fade in with a short staggered delay.

## About the images

`netflix_bg.jpg` and `netflix_intro.gif` are the reference assets you
provided and are bundled only inside this school project (declared in
`pubspec.yaml` under `flutter: assets:`) — they are not redistributed or
published anywhere else, since this is a private ITP107 lab activity for
your professor's checking only.

## Paano na-meet ang requirements

**Login Screen**
- Email/username field + password field (may show/hide password)
- "Sign In" button → `Navigator.pushReplacementNamed('/home', ...)`
- "Sign up now." link → `Navigator.pushNamed('/signup')`

**Sign-Up Screen**
- Full name, email, password, at confirm password fields (with validation
  na dapat magkatugma ang password at confirm password)
- "Sign Up" button → `Navigator.pushReplacementNamed('/home', arguments: name)`
- "Sign in now." link → `Navigator.pop()` pabalik sa Login

**Home Screen**
- Binabasa ang pangalan na ipinasa bilang **route arguments**
  (`ModalRoute.of(context)!.settings.arguments`) mula sa Sign-Up (o email
  prefix mula sa Login) at ipinapakita sa welcome message
- "Logout" button → `Navigator.pushNamedAndRemoveUntil('/login', (route) => false)`
  para linisin ang buong navigation stack

**Named Routes & Navigator methods used**
- Lahat ng screens ay naka-define bilang named routes sa `MaterialApp`
  gamit ang `onGenerateRoute` (para makapag-pasa ng arguments nang maayos)
- Ginamit na Navigator methods: `pushNamed`, `pushReplacementNamed`, `pop`,
  at `pushNamedAndRemoveUntil` — mas marami pa sa minimum na 2 na
  hinihingi ng lab.

**Consistent, professional UI**
- Iisang color palette lang (`NetflixColors`) at text style set
  (`NetflixTextStyles`) na ginagamit sa lahat ng tatlong screens, para
  siguradong magkatugma ang look — itim na background, pulang (Netflix
  red `#E50914`) accent buttons/logo, at parehong istilo ng text fields
  sa Login, Sign-Up, at Home.

## Paano patakbuhin sa Chrome (responsive)

```
flutter config --enable-web
flutter pub get
flutter run -d chrome
```

Automatic nang mag-a-adjust ang layout habang binabago mo ang laki ng
Chrome window/tab:
- **Maliit/phone-size tab**: full-width ang login/sign-up card, mas maliit
  ang logo, mas maliit ang poster tiles sa Home.
- **Tablet-size**: mas malapad ang card (fixed 440px, naka-center),
  katamtamang laki ng hero banner.
- **Desktop-size**: mas malaking hero banner sa Home, mas malalaking
  poster tiles, 460px ang login/sign-up card na naka-center sa gitna ng
  screen.

Ang breakpoints (600px at 1000px width) at lahat ng size logic ay nasa
`lib/theme/responsive.dart` — pwede mong i-adjust ang mga numbers doon
kung gusto mo ng ibang behavior.

## Tungkol sa browser tab title

Ang title na lumalabas sa Chrome tab ay "Netflix" na, kontrolado ng
`web/index.html` (`<title>Netflix</title>`) at ng `title:` property sa
`MaterialApp` (`lib/main.dart`). Kung dati mo nang na-run ang app at may
sarili nang na-generate na `web/` folder ang lumang copy mo, gamitin na
lang itong bagong na-download na buong folder (kasama na ang updated
`web/index.html`) — o kaya i-edit lang manually yung `<title>` tag doon.

## Bago i-submit

Wag kalimutang:
1. Palitan ang placeholder fields sa itaas ng lab form (pangalan, section, group members/roles, GitHub link).
2. I-fill up ang group roles (Navigation & Routing Lead, UI/UX Designer, Integration & Testing Lead) ayon sa aktwal na hinati niyo sa grupo.
3. Kumuha ng screenshots o screen recording ng buong flow: Login → Sign-Up → Home → Logout.
4. I-rename ang deliverable file/folder ayon sa format: `ITP107_FinalsLab1_Section_GroupNo`.
