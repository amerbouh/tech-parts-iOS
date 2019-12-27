//
//  Progress.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-24.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

typedef enum Progress {
    TO_DO = 0,
    COMPLETED,
    IN_PROGRESS
} Progress;

/**
 Generates a string representing the provided Progress enum case.
 
 @param progress A Progress enum case representing the progress the function will generate a string
                from.
 
 @return A string representing the enum case passed as an argument to the function.
 */
const char * string_from_progress(Progress progress);

/**
Generates a Progress enum case representing the provided string.

@param progress_string A string  representing the progress the function will generate.

@return A Progress enum case representing the  string passed as an argument to the function.
*/
const Progress progress_from_string(const char * progress_string);
