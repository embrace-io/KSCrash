//
//  KSCrashReportFilter.h
//
//  Created by Karl Stenerud on 2012-02-18.
//
//  Copyright (c) 2012 Karl Stenerud. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall remain in place
// in this source code.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class KSCrashReport;

/** Callback for filter operations.
 *
 * @param filteredReports The filtered reports (may be incomplete if "completed"
 *                        is false).
 * @param completed True if filtering completed.
 *                  Can be false due to a non-erroneous condition (such as a
 *                  user cancelling the operation).
 * @param error Non-nil if an error occurred.
 */
typedef void(^KSCrashReportFilterCompletion)(NSArray<KSCrashReport*>* _Nullable filteredReports,
                                             BOOL completed,
                                             NSError* _Nullable  error)
NS_SWIFT_UNAVAILABLE("Use Swift closures instead!");


/**
 * A filter receives a set of reports, possibly transforms them, and then
 * calls a completion method.
 */
NS_SWIFT_NAME(CrashReportFilter)
@protocol KSCrashReportFilter <NSObject>

/** Filter the specified reports.
 *
 * @param reports The reports to process.
 * @param onCompletion Block to call when processing is complete.
 */
- (void) filterReports:(NSArray<KSCrashReport*>*) reports
          onCompletion:(nullable KSCrashReportFilterCompletion) onCompletion;

@end


/** Conditionally call a completion method if it's not nil.
 *
 * @param onCompletion The completion block. If nil, this function does nothing.
 * @param filteredReports The parameter to send as "filteredReports".
 * @param completed The parameter to send as "completed".
 * @param error The parameter to send as "error".
 */
static inline void kscrash_callCompletion(KSCrashReportFilterCompletion _Nullable onCompletion,
                                          NSArray<KSCrashReport*>* _Nullable filteredReports,
                                          BOOL completed,
                                          NSError* _Nullable error)
{
    if(onCompletion)
    {
        onCompletion(filteredReports, completed, error);
    }
}

NS_ASSUME_NONNULL_END
