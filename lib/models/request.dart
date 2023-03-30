class Request{
  late String rider_id;
  late String driver_id;
  late String payment_methode;
  Request({
    required this.rider_id,
    required this.driver_id,
    this.payment_methode='Cash'

});
}