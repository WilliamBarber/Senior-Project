class OldReport {
  String title = 'no title';
  String date = 'no date';
  String category = 'no category';
  String description = 'no description';
  double severity = 0;
  double latitude = -1000;
  double longitude = -1000;
  String photos = 'no photos';

  OldReport(this.title, this.date, this.category, this.description,
      this.severity, this.latitude, this.longitude, this.photos);
  OldReport.noPhotos(this.title, this.date, this.category, this.description,
      this.severity, this.latitude, this.longitude);
  OldReport.noLocation(this.title, this.date, this.category, this.description,
      this.severity, this.photos);
  OldReport.noPhotosNoLocation(
      this.title, this.date, this.category, this.description, this.severity);
  OldReport.empty();

  String getTitle() {
    return title;
  }

  String getDate() {
    return date;
  }

  String getCategory() {
    return category;
  }

  String getDescription() {
    return description;
  }

  double getSeverity() {
    return severity;
  }

  double getLatitude() {
    return latitude;
  }

  double getLongitude() {
    return longitude;
  }

  String getPhotos() {
    return photos;
  }
}
