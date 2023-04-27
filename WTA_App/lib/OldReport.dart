class OldReport {
  String title = 'no title';
  String trailhead = 'no trailhead';
  String date = 'no date';
  String category = 'no category';
  String description = 'no description';
  double severity = 0;
  double latitude = -1000;
  double longitude = -1000;
  String image = 'no image';

  OldReport(this.title, this.trailhead, this.date, this.category, this.description,
      this.severity, this.latitude, this.longitude, this.image);
  OldReport.noImage(this.title, this.trailhead, this.date, this.category, this.description,
      this.severity, this.latitude, this.longitude);
  OldReport.noLocation(this.title, this.trailhead, this.date, this.category, this.description,
      this.severity, this.image);
  OldReport.noImageNoLocation(
      this.title, this.trailhead, this.date, this.category, this.description, this.severity);
  OldReport.empty();

  String getTitle() {
    return title;
  }

  String getTrailhead(){
    return trailhead;
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

  String getImage() {
    return image;
  }
}
