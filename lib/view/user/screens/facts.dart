import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Fact extends StatefulWidget {
  const Fact({super.key});
  @override

  // ignore: library_private_types_in_public_api
  _FactState createState() => _FactState();
}

class _FactState extends State<Fact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
          padding: const EdgeInsets.all(17),
          children: [  
             const SizedBox(height: 55),
              Align(          
                  alignment: Alignment.topLeft,
                  child: InkWell(
                  onTap: () {
                context.go('/');
              },
              child: const Icon(
               Icons.arrow_back,
                color: Color.fromARGB(255, 207, 111, 2),
                
              )),
        ),
            const Text(
              "Facts ",
              textAlign: TextAlign.center,
              style: TextStyle(
                  height: 1.5,
                  fontFamily: 'Inter',
                  fontSize: 35.0,
                  color: Color.fromARGB(255, 204, 122, 0)),
                
            ),
            fact1(),
            fact2(),
            fact3(),
            fact4(),
            
          
          ],
          
        ), 
    );
  }

  Widget fact1() => Card(
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(12),
        // ),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'The first dinosaur fossil was found around 1815.',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              // SizedBox(height: 4),
              // Text(
              //   'This card is rounded',
              //   style: TextStyle(fontSize: 20),
              // ),
              
            ],
          ),
        ),
      );

  Widget fact2() => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        
        child: Column(
          children: [
            Stack(
              children: [
                Ink.image(
                  image: const NetworkImage(
                    'https://cdnimgen.vietnamplus.vn/uploaded/kg1/2022_03_25/sand1.jpg',
                  ),

                  height: 240,
                  fit: BoxFit.cover,
                ),
              ],
            ),
             const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.all(16).copyWith(bottom: 0),
              child: const Text(
                'Finders keepers? You could go to jail for finding and keeping a fossil.',
                style: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
      );
      
Widget fact3() => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        
        child: Column(
          children: [
            Stack(
              children: [
                Ink.image(
                  image: const NetworkImage(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSEqkvdVtxzAYeBo_JHQzz7yQ50nbKNNnzBngixI1fvBDL-i7tOTvQ8TklWIs16i7ieVNY&usqp=CAU',
                  ),
                  height: 240,
                  fit: BoxFit.cover,
                ),
              ],
            ),
               const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.all(16).copyWith(bottom: 0),
              child: const Text(
                'Finders keepers? You could go to jail for finding and keeping a fossil.',
                style: TextStyle(fontSize: 20),
              ),
            ),
             const SizedBox(height: 15),
          ],
        ),
      );

Widget fact4() => Card(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'The first dinosaur fossil was found around 1815.',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      );
}
