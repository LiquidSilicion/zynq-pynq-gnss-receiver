; ModuleID = '/home/johan2/Documents/fpga/zynq-pynq-gnss-receiver/enhanced_correlator/enhanced_correlator/enhanced_correlator/hls/.autopilot/db/a.g.ld.5.gdce.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-i128:128-i256:256-i512:512-i1024:1024-i2048:2048-i4096:4096-n8:16:32:64-S128-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "fpga64-xilinx-none"

; Function Attrs: noinline
define void @apatb_enhanced_correlator_ir(float* noalias nocapture nonnull readonly "maxi" %signal_I, float* noalias nocapture nonnull readonly "maxi" %signal_Q, float* noalias nocapture nonnull %corr_E_I, float* noalias nocapture nonnull %corr_E_Q, float* noalias nocapture nonnull %corr_P_I, float* noalias nocapture nonnull %corr_P_Q, float* noalias nocapture nonnull %corr_L_I, float* noalias nocapture nonnull %corr_L_Q, i32 %num_samples, float %carrier_freq, float %carrier_phase_init, float %code_phase_init, float %code_freq, float %sample_rate, i32 %code_length, float %correlator_spacing, float* noalias nocapture nonnull readonly "maxi" %prn_code) local_unnamed_addr #0 {
entry:
  %0 = bitcast float* %signal_I to [100000 x float]*
  %1 = call i8* @malloc(i64 400000)
  %signal_I_copy = bitcast i8* %1 to [100000 x float]*
  %2 = bitcast float* %signal_Q to [100000 x float]*
  %3 = call i8* @malloc(i64 400000)
  %signal_Q_copy = bitcast i8* %3 to [100000 x float]*
  %corr_E_I_copy = alloca float, align 512
  %corr_E_Q_copy = alloca float, align 512
  %corr_P_I_copy = alloca float, align 512
  %corr_P_Q_copy = alloca float, align 512
  %corr_L_I_copy = alloca float, align 512
  %corr_L_Q_copy = alloca float, align 512
  %4 = bitcast float* %prn_code to [4092 x float]*
  %5 = call i8* @malloc(i64 16368)
  %prn_code_copy = bitcast i8* %5 to [4092 x float]*
  call fastcc void @copy_in([100000 x float]* nonnull %0, [100000 x float]* %signal_I_copy, [100000 x float]* nonnull %2, [100000 x float]* %signal_Q_copy, float* nonnull %corr_E_I, float* nonnull align 512 %corr_E_I_copy, float* nonnull %corr_E_Q, float* nonnull align 512 %corr_E_Q_copy, float* nonnull %corr_P_I, float* nonnull align 512 %corr_P_I_copy, float* nonnull %corr_P_Q, float* nonnull align 512 %corr_P_Q_copy, float* nonnull %corr_L_I, float* nonnull align 512 %corr_L_I_copy, float* nonnull %corr_L_Q, float* nonnull align 512 %corr_L_Q_copy, [4092 x float]* nonnull %4, [4092 x float]* %prn_code_copy)
  call void @apatb_enhanced_correlator_hw([100000 x float]* %signal_I_copy, [100000 x float]* %signal_Q_copy, float* %corr_E_I_copy, float* %corr_E_Q_copy, float* %corr_P_I_copy, float* %corr_P_Q_copy, float* %corr_L_I_copy, float* %corr_L_Q_copy, i32 %num_samples, float %carrier_freq, float %carrier_phase_init, float %code_phase_init, float %code_freq, float %sample_rate, i32 %code_length, float %correlator_spacing, [4092 x float]* %prn_code_copy)
  call void @copy_back([100000 x float]* %0, [100000 x float]* %signal_I_copy, [100000 x float]* %2, [100000 x float]* %signal_Q_copy, float* %corr_E_I, float* %corr_E_I_copy, float* %corr_E_Q, float* %corr_E_Q_copy, float* %corr_P_I, float* %corr_P_I_copy, float* %corr_P_Q, float* %corr_P_Q_copy, float* %corr_L_I, float* %corr_L_I_copy, float* %corr_L_Q, float* %corr_L_Q_copy, [4092 x float]* %4, [4092 x float]* %prn_code_copy)
  tail call void @free(i8* %1)
  tail call void @free(i8* %3)
  tail call void @free(i8* %5)
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_in([100000 x float]* readonly, [100000 x float]*, [100000 x float]* readonly, [100000 x float]*, float* readonly, float* align 512, float* readonly, float* align 512, float* readonly, float* align 512, float* readonly, float* align 512, float* readonly, float* align 512, float* readonly, float* align 512, [4092 x float]* readonly, [4092 x float]*) unnamed_addr #1 {
entry:
  call fastcc void @onebyonecpy_hls.p0a100000f32([100000 x float]* %1, [100000 x float]* %0)
  call fastcc void @onebyonecpy_hls.p0a100000f32([100000 x float]* %3, [100000 x float]* %2)
  call fastcc void @onebyonecpy_hls.p0f32(float* align 512 %5, float* %4)
  call fastcc void @onebyonecpy_hls.p0f32(float* align 512 %7, float* %6)
  call fastcc void @onebyonecpy_hls.p0f32(float* align 512 %9, float* %8)
  call fastcc void @onebyonecpy_hls.p0f32(float* align 512 %11, float* %10)
  call fastcc void @onebyonecpy_hls.p0f32(float* align 512 %13, float* %12)
  call fastcc void @onebyonecpy_hls.p0f32(float* align 512 %15, float* %14)
  call fastcc void @onebyonecpy_hls.p0a4092f32([4092 x float]* %17, [4092 x float]* %16)
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @onebyonecpy_hls.p0a100000f32([100000 x float]* %dst, [100000 x float]* readonly %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [100000 x float]* %dst, null
  %1 = icmp eq [100000 x float]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a100000f32([100000 x float]* nonnull %dst, [100000 x float]* nonnull %src, i64 100000)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a100000f32([100000 x float]* %dst, [100000 x float]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [100000 x float]* %src, null
  %1 = icmp eq [100000 x float]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr = getelementptr [100000 x float], [100000 x float]* %dst, i64 0, i64 %for.loop.idx2
  %src.addr = getelementptr [100000 x float], [100000 x float]* %src, i64 0, i64 %for.loop.idx2
  %3 = load float, float* %src.addr, align 4
  store float %3, float* %dst.addr, align 4
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @onebyonecpy_hls.p0f32(float* align 512 %dst, float* readonly %src) unnamed_addr #2 {
entry:
  %0 = icmp eq float* %dst, null
  %1 = icmp eq float* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %3 = load float, float* %src, align 4
  store float %3, float* %dst, align 512
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @onebyonecpy_hls.p0a4092f32([4092 x float]* %dst, [4092 x float]* readonly %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [4092 x float]* %dst, null
  %1 = icmp eq [4092 x float]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a4092f32([4092 x float]* nonnull %dst, [4092 x float]* nonnull %src, i64 4092)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a4092f32([4092 x float]* %dst, [4092 x float]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [4092 x float]* %src, null
  %1 = icmp eq [4092 x float]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr = getelementptr [4092 x float], [4092 x float]* %dst, i64 0, i64 %for.loop.idx2
  %src.addr = getelementptr [4092 x float], [4092 x float]* %src, i64 0, i64 %for.loop.idx2
  %3 = load float, float* %src.addr, align 4
  store float %3, float* %dst.addr, align 4
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_out([100000 x float]*, [100000 x float]* readonly, [100000 x float]*, [100000 x float]* readonly, float*, float* readonly align 512, float*, float* readonly align 512, float*, float* readonly align 512, float*, float* readonly align 512, float*, float* readonly align 512, float*, float* readonly align 512, [4092 x float]*, [4092 x float]* readonly) unnamed_addr #4 {
entry:
  call fastcc void @onebyonecpy_hls.p0a100000f32([100000 x float]* %0, [100000 x float]* %1)
  call fastcc void @onebyonecpy_hls.p0a100000f32([100000 x float]* %2, [100000 x float]* %3)
  call fastcc void @onebyonecpy_hls.p0f32(float* %4, float* align 512 %5)
  call fastcc void @onebyonecpy_hls.p0f32(float* %6, float* align 512 %7)
  call fastcc void @onebyonecpy_hls.p0f32(float* %8, float* align 512 %9)
  call fastcc void @onebyonecpy_hls.p0f32(float* %10, float* align 512 %11)
  call fastcc void @onebyonecpy_hls.p0f32(float* %12, float* align 512 %13)
  call fastcc void @onebyonecpy_hls.p0f32(float* %14, float* align 512 %15)
  call fastcc void @onebyonecpy_hls.p0a4092f32([4092 x float]* %16, [4092 x float]* %17)
  ret void
}

declare i8* @malloc(i64) local_unnamed_addr

declare void @free(i8*) local_unnamed_addr

declare void @apatb_enhanced_correlator_hw([100000 x float]*, [100000 x float]*, float*, float*, float*, float*, float*, float*, i32, float, float, float, float, float, i32, float, [4092 x float]*)

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_back([100000 x float]*, [100000 x float]* readonly, [100000 x float]*, [100000 x float]* readonly, float*, float* readonly align 512, float*, float* readonly align 512, float*, float* readonly align 512, float*, float* readonly align 512, float*, float* readonly align 512, float*, float* readonly align 512, [4092 x float]*, [4092 x float]* readonly) unnamed_addr #4 {
entry:
  call fastcc void @onebyonecpy_hls.p0f32(float* %4, float* align 512 %5)
  call fastcc void @onebyonecpy_hls.p0f32(float* %6, float* align 512 %7)
  call fastcc void @onebyonecpy_hls.p0f32(float* %8, float* align 512 %9)
  call fastcc void @onebyonecpy_hls.p0f32(float* %10, float* align 512 %11)
  call fastcc void @onebyonecpy_hls.p0f32(float* %12, float* align 512 %13)
  call fastcc void @onebyonecpy_hls.p0f32(float* %14, float* align 512 %15)
  ret void
}

declare void @enhanced_correlator_hw_stub(float* noalias nocapture nonnull readonly, float* noalias nocapture nonnull readonly, float* noalias nocapture nonnull, float* noalias nocapture nonnull, float* noalias nocapture nonnull, float* noalias nocapture nonnull, float* noalias nocapture nonnull, float* noalias nocapture nonnull, i32, float, float, float, float, float, i32, float, float* noalias nocapture nonnull readonly)

define void @enhanced_correlator_hw_stub_wrapper([100000 x float]*, [100000 x float]*, float*, float*, float*, float*, float*, float*, i32, float, float, float, float, float, i32, float, [4092 x float]*) #5 {
entry:
  call void @copy_out([100000 x float]* null, [100000 x float]* %0, [100000 x float]* null, [100000 x float]* %1, float* null, float* %2, float* null, float* %3, float* null, float* %4, float* null, float* %5, float* null, float* %6, float* null, float* %7, [4092 x float]* null, [4092 x float]* %16)
  %17 = bitcast [100000 x float]* %0 to float*
  %18 = bitcast [100000 x float]* %1 to float*
  %19 = bitcast [4092 x float]* %16 to float*
  call void @enhanced_correlator_hw_stub(float* %17, float* %18, float* %2, float* %3, float* %4, float* %5, float* %6, float* %7, i32 %8, float %9, float %10, float %11, float %12, float %13, i32 %14, float %15, float* %19)
  call void @copy_in([100000 x float]* null, [100000 x float]* %0, [100000 x float]* null, [100000 x float]* %1, float* null, float* %2, float* null, float* %3, float* null, float* %4, float* null, float* %5, float* null, float* %6, float* null, float* %7, [4092 x float]* null, [4092 x float]* %16)
  ret void
}

attributes #0 = { noinline "fpga.wrapper.func"="wrapper" }
attributes #1 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="copyin" }
attributes #2 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="onebyonecpy_hls" }
attributes #3 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="arraycpy_hls" }
attributes #4 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="copyout" }
attributes #5 = { "fpga.wrapper.func"="stub" }

!llvm.dbg.cu = !{}
!llvm.ident = !{!0, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1, !1}
!llvm.module.flags = !{!2, !3, !4}
!blackbox_cfg = !{!5}

!0 = !{!"AMD/Xilinx clang version 16.0.6"}
!1 = !{!"clang version 7.0.0 "}
!2 = !{i32 2, !"Dwarf Version", i32 4}
!3 = !{i32 2, !"Debug Info Version", i32 3}
!4 = !{i32 1, !"wchar_size", i32 4}
!5 = !{}
