part of petisland.notification.widget;

class NotificationDefaultWidget extends StatelessWidget {
  final Random random = DI.get(Random);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      child: Flex(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        direction: Axis.horizontal,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: _buildCircle(),
            ),
          ),
          Flexible(
            child: _buildDetailLoading(),
            flex: 6,
          ),
        ],
      ),
    );
  }

  Widget _buildCircle() {
    return TImageLoading(
      child: Container(
        alignment: Alignment.topLeft,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: TColors.duck_egg_blue,
        ),
      ),
    );
  }

  Widget _buildDetailLoading() {
    return Flex(
      direction: Axis.vertical,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Flexible(
          flex: 3,
          child: _buildMessageLoading(),
        ),
        SizedBox(height: 5),
        Flexible(
          child: Container(
            alignment: Alignment.centerRight,
            child: _buildTimeLoading(),
          ),
        )
      ],
    );
  }

  Widget _buildMessageLoading() {
    return TImageLoading(
      child: Container(
        height: random.nextInt(35) + 35.0,
        decoration: BoxDecoration(
          color: TColors.duck_egg_blue,
          borderRadius: BorderRadius.circular(3),
        ),
      ),
    );
  }

  Widget _buildTimeLoading() {
    return TImageLoading(
      child: Container(
        width: random.nextInt(55) + 55.0,
        decoration: BoxDecoration(
          color: TColors.duck_egg_blue,
          borderRadius: BorderRadius.circular(3),
        ),
      ),
    );
  }
}
