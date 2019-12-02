import 'package:flutter/material.dart';

class DashboardEventsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rapatory'),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          _buildWidgetCirclePhotoProfile(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: <Widget>[
                Text(
                  'Your Events',
                  style: Theme.of(context).textTheme.title,
                ),
                _buildWidgetFilterEvents(),
              ],
            ),
            // TODO: do something in here
          ],
        ),
      ),
    );
  }

  Widget _buildWidgetFilterEvents() {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: <Widget>[
        Text(
          'Filter: ',
          style: TextStyle(color: Colors.grey),
        ),
        Text('All'),
        Icon(
          Icons.arrow_drop_down,
          size: 14.0,
        ),
        SizedBox(width: 8.0),
        Text(
          'Sort: ',
          style: TextStyle(color: Colors.grey),
        ),
        Text('Newest'),
        Icon(
          Icons.arrow_drop_down,
          size: 14.0,
        ),
      ],
    );
  }

  Widget _buildWidgetCirclePhotoProfile() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 12.0,
        ),
        child: CircleAvatar(
          radius: 20.0,
          backgroundImage: AssetImage(
            'assets/images/img_photo_profile_sample.jpg',
          ),
        ),
      ),
    );
  }
}
