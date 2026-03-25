# Renty Bookings Screen Implementation TODO

## Plan Steps
- [x] 1. Update Booking model: add reference, ownerName, pickupLocation, totalPaid, ownerPhone fields + JSON serialization.
- [x] 2. Update BookingsProvider: add upcoming/past/cancelled getters; extend generateSampleBooking.
- [x] 3. Update MyBookingsScreen: implement TabBar (Upcoming/Past/Cancelled with counts), per-tab empty states, revamped booking cards (badge ref dates duration owner total Call/Message buttons).
- [x] 4. No new dependencies needed (mock Call with SnackBar).
**All steps complete.**

Navigate to Profile > My Bookings to see empty state. To populate for testing: in debug console or temp button call provider.addBooking(provider.generateSampleBooking('1')) etc.


