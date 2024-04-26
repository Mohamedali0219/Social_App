import 'package:flutter/material.dart';
import 'package:flutter_iconoir_ttf/flutter_iconoir_ttf.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 10,
            margin: EdgeInsets.all(8.0),
            child: Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                Image(
                  image: NetworkImage(
                      'https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w1200/2023/10/free-images.jpg'),
                  fit: BoxFit.fill,
                  width: double.infinity,
                  height: 250,
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Communications with friends',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
            itemBuilder: (context, index) => buildPostItem(context),
            itemCount: 10,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
          ),
        ],
      ),
    );
  }
}

Widget buildPostItem(context) {
  return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 10,
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                      'https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w1200/2023/10/free-images.jpg'),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Text(
                            'Mohamed Ali',
                            style: TextStyle(
                              height: 1.4,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.check_circle,
                            color: Colors.blue,
                            size: 18,
                          )
                        ],
                      ),
                      Text(
                        'June 15, 2023',
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              height: 1.4,
                            ),
                      )
                    ],
                  ),
                ),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.more_horiz)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Container(
                width: double.infinity,
                height: 2,
                color: Colors.grey[300],
              ),
            ),
            const Text(
              'sdjshhkjsd flksdhfwjkhf; zfshfhsdkfhkshfkhfk sksdhfk hsfhkshfkshk hskfhks hkhskfhk shfk hsfkhs kfhkshf kshfkh skfhkshf skfhkshsdfi s hfkshfk hfh hfkjshfk shfkhsfjshhhsgdfh kshkshfsh fksk hsfh s khfksdhfk shfkh skfhskfkshflhsgkljehkhsfklhsdfkhskhdf ksh',
              style: TextStyle(
                height: 1.4,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Wrap(
                children: [
                  InkWell(
                    onTap: () {},
                    child: const Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        '#flutter',
                        style: TextStyle(color: Colors.blue, fontSize: 16),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: const Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        '#flutter',
                        style: TextStyle(color: Colors.blue, fontSize: 16),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: const Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        '#flutter',
                        style: TextStyle(color: Colors.blue, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              height: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                image: const DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      'https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w1200/2023/10/free-images.jpg'),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        const Icon(
                          IconoirIcons.heart,
                          color: Colors.red,
                          size: 18,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          '120',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(fontSize: 14),
                        )
                      ],
                    ),
                  ),
                )),
                Expanded(
                    child: InkWell(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(
                          IconoirIcons.chatPlusIn,
                          color: Colors.amber,
                          size: 18,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          '120 comment',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(fontSize: 14),
                        )
                      ],
                    ),
                  ),
                )),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Container(
                width: double.infinity,
                height: 2,
                color: Colors.grey[300],
              ),
            ),
            Row(
              children: [
                const CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                      'https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w1200/2023/10/free-images.jpg'),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Text(
                      'write a comment ...',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            fontSize: 16,
                          ),
                    ),
                  ),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      IconoirIcons.heart,
                      color: Colors.red,
                      size: 24,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('like',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ))
                  ],
                ),
              ],
            ),
          ],
        ),
      ));
}
