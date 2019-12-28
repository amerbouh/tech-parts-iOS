//
//  UserRole.c
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-27.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#include <string.h>
#include "UserRole.h"

const char * MENTOR_IDENTIFIER = "mentor";
const char * STUDENT_IDENTIFIER = "student";

const char * string_from_user_role(UserRole user_role)
{
    if (user_role == MENTOR) return MENTOR_IDENTIFIER;
                             return STUDENT_IDENTIFIER;
}

const UserRole user_role_from_string(const char * user_role_string)
{
    if (strncmp(user_role_string, MENTOR_IDENTIFIER, sizeof(*user_role_string)) == 0) return MENTOR;
                                                                                      return STUDENT;
}
