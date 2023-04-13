class OldReport{
  String title = 'no title';
  String date = 'no date';
  String category = 'no category';
  String description = 'no description';
  double severity = 0;
  String location = 'no location';
  String photos = 'no photos';

  OldReport(this.title, this.date, this.category, this.description, this.severity, this.location, this.photos);
  OldReport.noPhotos(this.title, this.date, this.category, this.description, this.severity, this.location);
  OldReport.empty();

  String getTitle(){
    return title;
  }

  String getDate(){
    return date;
  }

  String getCategory(){
    return category;
  }

  String getDescription(){
    return description;
  }

  double getSeverity(){
    return severity;
  }

  String getLocation(){
    return location;
  }

  String getPhotos(){
    return photos;
  }
}