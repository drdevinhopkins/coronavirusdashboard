// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });

const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

exports.newScreenTrigger = functions.firestore
    .document('jgh-ed/{newScreen}')
    .onCreate((snap, context) => {
        // Get an object representing the document
        // e.g. {'name': 'Marie', 'age': 66}
        const newScreen = snap.data();

        // access a particular field as you would any JS property
        const result = newScreen.result;
        const anyTravel = newScreen.anyTravel;
        const asymptomaticTravel = newScreen.asymptomaticTravel;
        const contactTravel = newScreen.contactTravel;
        const language = newScreen.language;
        const symptomaticTravel = newScreen.symptomaticTravel;
        const symptoms = newScreen.symptoms;
        const timestamp = newScreen.timestamp;

        // console.log('I am a log entry!');
        // console.log(result);

        const jghStats = admin.firestore().collection('stats').doc('jgh-ed');

        return jghStats.get().then(docSnapshot => {

            const totalCount = docSnapshot.data().totalCount
            const newTotalCount = totalCount + 1;

            var data = {};
            data['totalCount'] = newTotalCount;

            return jghStats.update(data);

        }).catch(err => console.log(err))

        // perform desired operations ...
    });


// exports.aggregateScreenings = functions.firestore
//     .document('jgh-ed/{screenId}')
//     .onWrite((snap, context) => {

//         // const newScreen = snap.data();

//         const anyTravel = snap.get('anyTravel');
//         const asymptomaticTravel = snap.get('asymptomaticTravel');
//         const contactTravel = snap.get('contactTravel');
//         const language = snap.get('language');
//         const result = snap.get('result');
//         const symptomaticTravel = snap.get('symptomaticTravel');
//         const symptoms = snap.get('symptoms');
//         const timestamp = snap.get('timestamp');

//         // const screenId = event.params.screenId;

//         // ref to the parent document
//         const jghStats = admin.firestore().collection('stats').doc('jgh-ed');
//         // const screensRef = admin.firestore().collection('jgh-ed');
//         return jghStats
//             .get()
//             .then(docSnapshot => {


//                 // get all comments and aggregate
//                 // return screensRef.orderBy('timestamp', 'desc')
//                 //     .get()
//                 //     .then(querySnapshot => {

//                 const totalCount = docSnapshot.data().totalCount
//                 const newTotalCount = totalCount + 1;

//                 // get the total comment count
//                 // const screenCount = querySnapshot.size;

//                 // const last10Screens = [];

//                 // // add data from the 5 most recent comments to the array
//                 // querySnapshot.forEach(doc => {
//                 //     last10Screens.push(doc.data())
//                 // });

//                 // last10Screens.splice(10);

//                 // // record last comment timestamp
//                 // const lastActivity = last10Screens[0].createdAt;

//                 // data to update on the document
//                 // const data = { screenCount, last10Screens, lastActivity };
//                 const data = { totalCount: newTotalCount };


//                 // run update
//                 return jghStats.update(data);
//             })
//             .catch(err => console.log(err))
//     });
