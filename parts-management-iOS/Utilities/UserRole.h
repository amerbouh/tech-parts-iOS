//
//  UserRole.h
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-27.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#ifndef UserRole_h
#define UserRole_h

#include <stdio.h>

typedef enum UserRole {
    MENTOR,
    STUDENT
} UserRole;

/**
 Generates a string representing the provided User Role enum case.
 
 @param user_role A User Role enum case representing the role the function will generate a string
                 from.
 
 @return A string representing the enum case passed as an argument to the function.
 */
const char * string_from_user_role(UserRole user_role);

/**
Generates a User Role enum case representing the provided string.

@param user_role_string A string representing the user role the function will generate.

@return A User Role enum case representing the  string passed as an argument to the function.
*/
const UserRole user_role_from_string(const char * user_role_string);

#endif /* UserRole_h */
