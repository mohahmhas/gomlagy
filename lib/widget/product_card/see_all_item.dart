import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../helpers/base_url.dart' as baseurl;

class SeeAllItemContainer extends StatelessWidget {
  final String name;
  final String thumbnailPath;

  const SeeAllItemContainer(
      {
      this.name,
      this.thumbnailPath,
      });

  @override
  Widget build(BuildContext context) {
    return Container(
                 width: MediaQuery.of(context).size.width / 2,
                 height: MediaQuery.of(context).size.height/4,
                 margin: EdgeInsets.only(bottom:10),
                  // height: 120,
                 child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
               // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                   Container(
                     child:thumbnailPath != null ?
                        Container(
                          height: MediaQuery.of(context).size.height/8,
                         // color: Colors.,
                          child: CachedNetworkImage(
                            fit: BoxFit.fill,
                            placeholder: (context, url) => CircularProgressIndicator(),
                            imageUrl: thumbnailPath,
                       ),
                        ) : Center(child: CircularProgressIndicator()), 

                    ) ,
                  Text(name,maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 16 , color: Colors.grey[500]),) ,
                  ],
                 ),
                );
  }
}
