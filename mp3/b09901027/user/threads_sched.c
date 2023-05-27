#include "kernel/types.h"
#include "user/user.h"
#include "user/list.h"
#include "user/threads.h"
#include "user/threads_sched.h"

#define NULL 0

/* default scheduling algorithm */
struct threads_sched_result schedule_default(struct threads_sched_args args)
{
    struct thread *thread_with_smallest_id = NULL;
    struct thread *th = NULL;
    list_for_each_entry(th, args.run_queue, thread_list) {
        if (thread_with_smallest_id == NULL || th->ID < thread_with_smallest_id->ID) {
            thread_with_smallest_id = th;
        }
    }

    struct threads_sched_result r;
    if (thread_with_smallest_id != NULL) {
        r.scheduled_thread_list_member = &thread_with_smallest_id->thread_list;
        r.allocated_time = thread_with_smallest_id->remaining_time;
    } else {
        r.scheduled_thread_list_member = args.run_queue;
        r.allocated_time = 1;
    }

    return r;
}

/* Earliest-Deadline-First scheduling */
struct threads_sched_result schedule_edf(struct threads_sched_args args)
{
    // the scheduling is called when a interrupt event happens (either a fn end or a new one is added)
    // need to determine the next thread to execute and the allocated time.

    struct threads_sched_result r;
    if(list_empty(args.run_queue)){
        // SPEC 3
        r.scheduled_thread_list_member = args.run_queue;
        int least_release_time = 99999;
        struct release_queue_entry* cur;
        list_for_each_entry(cur, args.release_queue, thread_list) {
            if(cur->release_time<least_release_time){
                least_release_time = cur->release_time;
            }
        }
        r.allocated_time = least_release_time - args.current_time ;
        return r;
    }else{
        // run queue is not empty.
        struct thread *th = NULL;
        struct thread *min_th = NULL;
        struct thread *min_miss_deadline_th = NULL;
        list_for_each_entry(th, args.run_queue, thread_list) {
            // printf("in run queue: %d\n", th->ID);
            if(th->current_deadline <= args.current_time){
                if(min_miss_deadline_th == NULL || th->ID<min_miss_deadline_th->ID){
                    min_miss_deadline_th = th;
                }
            }
            if(min_th == NULL) min_th = th;
            if(th->current_deadline<min_th->current_deadline){
                min_th = th;
            }else if(th->current_deadline == min_th->current_deadline){
                if(th->ID<min_th->ID) min_th = th;
            }
        }

        if(min_miss_deadline_th != NULL) {
            // SPEC 4: exist missed deadline
            // printf("exist missed deadline", th->ID);
            r.allocated_time = 0;
            r.scheduled_thread_list_member = &min_miss_deadline_th->thread_list;
            return r;
        }else{
            // no missed deadline, and run queue is not empty.

             // compute allocated time: 
            // 1. a preemption can happen in the future.(need to inspect the release queue)
            // 2. current deadline is met (preemption has not happened)
            // 3. current deadline is missed (current_time + remaining_time > current_deadline)
            // compute the first event that will happen.
            r.scheduled_thread_list_member = &min_th->thread_list;

            struct release_queue_entry* cur;
            if(list_empty(args.release_queue)){
                // printf("release queue is empty\n");
                // a preemption cannot happen, because we've already selected the highest priority thread.
                int remaining_time = 99999;

                int deadline_time = min_th->current_deadline - args.current_time;
                remaining_time = deadline_time<remaining_time? deadline_time: remaining_time;
                int met_time = min_th->remaining_time;
                remaining_time = met_time<remaining_time? met_time: remaining_time;
                r.allocated_time = remaining_time;
            }else{
                // first check if a preemption can happen
                struct release_queue_entry* cur_min = NULL;
                int remaining_time = 99999;
                list_for_each_entry(cur, args.release_queue, thread_list) {
                    if((cur->thrd->period + cur->release_time < min_th->current_deadline) && cur->thrd->n != 0){
                        // printf("preemption can occur: %d %d %d\n", cur->thrd->period , cur->release_time , min_th->current_deadline);
                        // a preemption can occur
                        if(cur_min == NULL){
                            cur_min = cur;
                        }else{
                            if((cur->thrd->period + cur->release_time < cur_min->thrd->period + cur_min->release_time)&& cur->thrd->n != 0){
                                cur_min = cur;
                            }else if(cur->thrd->period + cur->release_time == cur_min->thrd->period + cur_min->release_time){
                                if(cur_min->thrd->ID > cur->thrd->ID){
                                    cur_min = cur;
                                }
                            }
                        }
                    }
                }
                if(cur_min != NULL){
                    // a preemption is possible
                    remaining_time = cur_min->release_time - args.current_time;
                }
                int deadline_time = min_th->current_deadline - args.current_time;
                remaining_time = deadline_time<remaining_time? deadline_time: remaining_time;
                int met_time = min_th->remaining_time;
                remaining_time = met_time<remaining_time? met_time: remaining_time;
                r.allocated_time = remaining_time;
            }

            return r;
        }
    }

    return schedule_default(args);
}

/* Rate-Monotonic Scheduling */
struct threads_sched_result schedule_rm(struct threads_sched_args args)
{
    
    struct threads_sched_result r;
    if(list_empty(args.run_queue)){
        // SPEC 3
        r.scheduled_thread_list_member = args.run_queue;
        int least_release_time = 99999;
        struct release_queue_entry* cur;
        list_for_each_entry(cur, args.release_queue, thread_list) {
            if(cur->release_time<least_release_time){
                least_release_time = cur->release_time;
            }
        }
        r.allocated_time = least_release_time - args.current_time ;
        return r;
    }else{
        // run queue is not empty.
        struct thread *th = NULL;
        struct thread *min_th = NULL;
        struct thread *min_miss_deadline_th = NULL;
        list_for_each_entry(th, args.run_queue, thread_list) {
            if(th->current_deadline <= args.current_time){
                if(min_miss_deadline_th == NULL || th->ID<min_miss_deadline_th->ID){
                    min_miss_deadline_th = th;
                }
            }
            if(min_th == NULL) min_th = th;
            if(th->period<min_th->period){
                min_th = th;
            }else if(th->period == min_th->period){
                if(th->ID<min_th->ID) min_th = th;
            }
        }

        if(min_miss_deadline_th != NULL) {
            // SPEC 4: exist missed deadline
            r.allocated_time = 0;
            r.scheduled_thread_list_member = &min_miss_deadline_th->thread_list;
            return r;
        }else{
            // no missed deadline, and run queue is not empty.

             // compute allocated time: 
            // 1. a preemption can happen in the future.(need to inspect the release queue)
            // 2. current deadline is met (preemption has not happened)
            // 3. current deadline is missed (current_time + remaining_time > current_deadline)
            // compute the first event that will happen.
            r.scheduled_thread_list_member = &min_th->thread_list;

            struct release_queue_entry* cur;
            if(list_empty(args.release_queue)){
                // a preemption cannot happen, because we've already selected the highest priority thread.
                int remaining_time = 99999;

                int deadline_time = min_th->current_deadline - args.current_time;
                remaining_time = deadline_time<remaining_time? deadline_time: remaining_time;
                int met_time = min_th->remaining_time;
                remaining_time = met_time<remaining_time? met_time: remaining_time;
                
                r.allocated_time = remaining_time;
            }else{
                // first check if a preemption can happen
                struct release_queue_entry* cur_min = NULL;
                int remaining_time = 99999;
                list_for_each_entry(cur, args.release_queue, thread_list) {
                    if(cur->thrd->period<min_th->period){
                        // a preemption can occur
                        if(cur_min == NULL){
                            cur_min = cur;
                        }else{
                            if(cur_min->thrd->period>cur->thrd->period){
                                cur_min = cur;
                            }else if(cur_min->thrd->period == cur->thrd->period){
                                if(cur_min->thrd->ID > cur->thrd->ID){
                                    cur_min = cur;
                                }
                            }
                        }
                    }
                }
                if(cur_min != NULL){
                    // a preemption is possible
                    remaining_time = cur_min->release_time - args.current_time;
                }
                int deadline_time = min_th->current_deadline - args.current_time;
                remaining_time = deadline_time<remaining_time? deadline_time: remaining_time;
                int met_time = min_th->remaining_time;
                remaining_time = met_time<remaining_time? met_time: remaining_time;
                
                r.allocated_time = remaining_time;
            }

            return r;
        }
    }
}
