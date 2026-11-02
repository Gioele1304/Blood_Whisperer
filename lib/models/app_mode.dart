enum AppMode {
  cycleTracking,
  tryingToConceive,
  pregnancy,
  perimenopause,
}

extension AppModeX on AppMode {
  String get label {
    switch (this) {
      case AppMode.cycleTracking:
        return 'Monitoraggio Ciclo';
      case AppMode.tryingToConceive:
        return 'Ricerca Gravidanza';
      case AppMode.pregnancy:
        return 'Gravidanza';
      case AppMode.perimenopause:
        return 'Perimenopausa';
    }
  }

  String get description {
    switch (this) {
      case AppMode.cycleTracking:
        return 'Traccia il tuo ciclo mestruale e i sintomi quotidiani.';
      case AppMode.tryingToConceive:
        return 'Individua la finestra fertile e monitora l\'ovulazione.';
      case AppMode.pregnancy:
        return 'Segui la gestazione settimana per settimana.';
      case AppMode.perimenopause:
        return 'Monitora cicli irregolari e sintomi della transizione.';
    }
  }
}
