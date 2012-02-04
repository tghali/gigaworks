//
//  main.m
//  Tabelle_10*10
//
//  Created by Sysadmin on 28.03.08.
//  Copyright __Ruedi Heimlicher__ 2011. All rights reserved.
//

#import <Cocoa/Cocoa.h>

int main(int argc, char *argv[])
{
      int zaehler; 

      printf ("\n\nEs wurden folgende %d Parameter uebergeben :\n\n", argc ); 

      for ( zaehler = 0 ; zaehler < argc ; zaehler++ ) printf ("%s ", argv [zaehler] );
	  
    return NSApplicationMain(argc,  (const char **) argv);
}
