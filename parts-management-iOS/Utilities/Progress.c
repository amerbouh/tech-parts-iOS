//
//  Progress.c
//  parts-management-iOS
//
//  Created by Anas Merbouh on 2019-12-25.
//  Copyright © 2019 Anas Merbouh. All rights reserved.
//

#include <string.h>
#include "Progress.h"

const char * TO_DO_IDENTIFIER = "toDo";
const char * COMPLETED_IDENTIFIER = "completed";
const char * IN_PROGRESS_IDENTIFIER = "inProgress";

const char * string_from_progress(Progress progress)
{
    if (progress == TO_DO)       return TO_DO_IDENTIFIER;
    if (progress == IN_PROGRESS) return IN_PROGRESS_IDENTIFIER;
    return COMPLETED_IDENTIFIER;
}

const Progress progress_from_string(const char * progress_string)
{
    if (strncmp(progress_string, TO_DO_IDENTIFIER, sizeof(*progress_string)) == 0)       return TO_DO;
    if (strncmp(progress_string, IN_PROGRESS_IDENTIFIER, sizeof(*progress_string)) == 0) return IN_PROGRESS;
    return COMPLETED;
}
