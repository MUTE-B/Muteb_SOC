

from datetime import datetime



NOTES=[]



def add_note(data):


    note={


        "id":

        len(NOTES)+1,


        "analyst":

        data.get("analyst","SOC Analyst"),


        "case":

        data.get("case"),


        "note":

        data.get("note"),


        "time":

        str(datetime.utcnow())

    }


    NOTES.append(note)


    return note




def get_notes():


    return NOTES

