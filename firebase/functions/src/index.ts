import {firestore, initializeApp} from "firebase-admin";
import * as functions from "firebase-functions";

initializeApp();

export const scheduledFunction = functions.pubsub.schedule("every 5 minutes")
    .onRun(async () => {
      console.log("Checking for programs that need run...");
      const today = new Date().getDay();
      console.log(`Day of week is ${today}`);
      const users = await firestore().collection("users").get();
      for (let i = 0; i < users.size; i++) {
          // Get user's programs
          const programs = await users.docs[i].ref.collection('programs').get();
          for (let j = 0; j < programs.size; j++) {
              const program = await programs.docs[j].ref.get();
              const programData = program.data();
              if (programData == undefined) {
                  continue;
              }
              const programName = programData.name;
              let programShouldRun = false;
              if (today == 1) {
                  programShouldRun = programData.monday == 1;
              } else if (today == 2) {
                  programShouldRun = programData.tuesday == 1;
              } else if (today == 3) {
                  programShouldRun = programData.wednesday == 1;
              } else if (today == 4) {
                programShouldRun = programData.thursday == 1;
              } else if (today == 5) {
                programShouldRun = programData.friday == 1;
              } else if (today == 6) {
                programShouldRun = programData.saturday == 1;
              } else if (today == 7) {
                programShouldRun = programData.sunday == 1;
              }
              console.log(`${programName} should run: ${programShouldRun}`);
          }
      }
      return null;
    });
